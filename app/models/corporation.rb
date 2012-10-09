# -*- coding: utf-8 *-*
class Corporation < ActiveRecord::Base
  require "open-uri"
  require 'net/http'
  require 'hpricot'
  require 'date'
  include MEGAFON
  
  def logging(message)
    log = Logger.new(File.join(Rails.root, "log", 'corporation.log'))
    log.debug DateTime.now + message
  end
  # => Association's
  belongs_to  :rate_corpo
  belongs_to  :user, :dependent => :destroy
  has_many    :abonents,                :dependent => :destroy
  has_many    :corporation_payments,    :dependent => :destroy
  has_many    :corporation_debits,      :dependent => :destroy
  has_many    :corporation_saldos,      :dependent => :destroy
  
  # => Callback's  
  after_create  :xml_response
# after_create  :create_user # => Раньше регистрация пользователей была автоматической, при создании корпорации
  #after_create  :add_default_tarif
  before_create :add_start_day
  after_update  :change_status_after_delay
  after_create  :change_status_after_delay
  
  # => Validate's
  validates_uniqueness_of :phone

  def show_status
    self.status == 0 ? "Не активен" : "Активен"
  end

  # def create_user
  #   u = User.create(:username => self.phone.to_s, :password => self.password)
  #   self.update_attributes(:user => u)
  # end

  def xml_response
    source = open("https://serviceguide.megafonkavkaz.ru/ROBOTS/SC_TRAY_INFO?X_Username=#{self.phone}&X_Password=#{self.password}")
    data = Nokogiri::XML(source)
    @subscribers = data.css("GET_SUBSCRIBERS MSISDN").map {|node| node.children.text }
    @subscribers.each do |sub|
      Abonent.create!(:phone => sub, :corporation => self) if Abonent.find_by_phone(sub).nil?
    end
    self.update_attributes(:name => data.css("NAME").first.text,:balance_megafon => data.css("BALANCE").text, :rate_megafon => data.css("RATE_PLAN").text, :number_count => @subscribers.count, :status => data.css("STATUS").text)
  end

  def add_start_day
    self.corporation_saldos.build(:corporation => self, :startDay => "0")
  end

  def change_status_after_delay
    pays = self.corporation_payments.collect{|pay| pay.amount}
    debits = self.corporation_debits.collect{|pay| pay.amount}
    balance = pays.sum - debits.sum
    if self.status == 0 and self.delay > 0
      self.update_attributes(:status => 1)
    elsif self.status == 1 and self.delay == 0 and balance <= 0
      self.update_attributes(:status => 0)
    end
  end

  def change_status
    corporation_pays = corporation_payments.collect{|pay| pay.amount}
    corporation_debts = corporation_debits.collect{|pay| pay.amount}
    balance = corporation_pays.sum - corporation_debts.sum
    delay = delay.to_i
    stat = if (delay == 0) and (balance <= 0) then false else true end
    update_attributes(:status => stat)
  end

  def change_delay
    del = delay > 0 ? delay - 1 : 0
    update_attribute(:delay, del)
  end

  def charge
    pay = rate_corpo.nil? ? 0 : rate_corpo.pay
    corporation_debits.create!(:amount => pay) if status == 1
  end

# ====== From model Abonent ==============================
  def change_abonent_status


    abonents_to_lock = []
    abonents_to_unlock = []

    abonents.each do |abonent|
      abonent_pays = abonent.abonent_payments.collect{|pay| pay.amount}
      abonent_debits = abonent.abonent_debits.collect{|pay| pay.amount}
      balance = abonent_pays.sum - abonent_debits.sum
      delay = abonent.delay.to_i

      if !abonent.suspend? and abonent.abonent_tarif
        # => Проверка тарифа
        if abonent.abonent_tarif.monthly?

          # => Проверка было ли списание у абонента 
          if abonent.abonent_debits.last
            last_debit = abonent.abonent_debits.last    #Последнее списание

            # => Последнее списание было по ежемесячному тарифу?
            if last_debit.abonent_tarif.monthly?        #Если последнее списание ежемесячное
              last_debit_day = abonent.abonent_debits.last.created_at

              # => Прошло ли 30 дней с последнего списания
              if last_debit_day.to_date + 30.day == Date.current

                if (delay == 0) and (balance < abonent.abonent_tarif.tarif)
                  lock_abonent(abonent, abonents_to_lock)
                else
                  unlock_abonent(abonent, abonents_to_unlock)
                end
              end

            # => Если последнее списание не по ежемесячному списанию
            else
              if (delay == 0) and (balance < abonent.abonent_tarif.tarif)
                lock_abonent(abonent, abonents_to_lock)
              else
                unlock_abonent(abonent, abonents_to_unlock)
              end
            end

          # => Если предедущих списаний нет
          else
            if (delay == 0) and (balance < abonent.abonent_tarif.tarif)
              lock_abonent(abonent, abonents_to_lock)
            else
              unlock_abonent(abonent, abonents_to_unlock)
            end
          end

        # => Если тариф не ежемесячный
        else
          if (delay == 0) and (balance < abonent.abonent_tarif.tarif)
            lock_abonent(abonent, abonents_to_lock)
          else
            unlock_abonent(abonent, abonents_to_unlock) 
          end                      
        end
      elsif !abonent.suspend? and !abonent.abonent_tarif
    	    if balance <= 0 and delay == 0
            lock_abonent(abonent, abonents_to_lock)
          end
      end

    end

    

    try_index = 0
    begin
      MEGAFON::Megafon.new(phone, password, [abonents_to_lock,abonents_to_unlock]) \
        unless (abonents_to_lock.empty? and abonents_to_unlock.empty?)
    rescue => err
      puts err
      try_index += 1
      if try_index < 1000
        puts "Tried #{try_index} times"
        retry
      else
        lock_flag = false
        puts "We tried 10 times but..."
      end
    end

  end

  def check_start_date
    abonents.each do |abonent|
      abonent.update_attributes(:suspend => false) if abonent.start_date == Date.current
    end
  end
  
  def lock_abonent(abonent, lock_array)
    lock_array << abonent.phone.to_s
    abonent.update_attributes(:status => false)
    logging("Заблокирован абонент #{abonent.phone.to_s} --- #{abonent.corporation.name}")    
  end

  def unlock_abonent(abonent, unlock_array)
    unlock_array << abonent.phone.to_s
    abonent.update_attributes(:status => true)
    logging("Разблокирован абонент #{abonent.phone.to_s} --- #{abonent.corporation.name}")     
  end



  def charge_abonent
    abonents.each do |abonent|
      next if abonent.abonent_tarif.nil?
      abonent.charge
    end
  end

  def change_abonent_delay
    abonents.each do |abonent|
      abonent.change_delay
    end
  end

# =======================================================================================

  def add_default_tarif
    AbonentTarif.create!(:name => "Стартовый", :tarif => 15, :corporation_id => self.id)
  end

  def self.change_status_hourly
    corporations = Corporation.all
    corporations.each do |corporation|
      corporation.change_abonent_status
    end
  end


  def self.end_day
    corporations = Corporation.all
    corporations.each do |corporation|
      corporation.charge
      corporation.change_status
      corporation.change_delay
      corporation.change_abonent_status
      corporation.check_start_date
      corporation.charge_abonent
      corporation.change_abonent_delay
      CorporationSaldo.balance_start_day(corporation)
      AbonentSaldo.balance_start_day(corporation)
      corporation.xml_response()
    end
  end

end

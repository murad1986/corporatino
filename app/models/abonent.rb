# -*- coding: utf-8 -*-
class Abonent < ActiveRecord::Base

  #Associations
  belongs_to  :corporation
  has_many    :abonent_saldos,    :dependent => :destroy
  has_many    :abonent_debits,    :dependent => :destroy
  has_many    :abonent_payments,  :dependent => :destroy
  belongs_to  :abonent_tarif
  
  #Callback's
  after_create  :addStartDay
  after_update  :change_status_after_delay
  after_create  :change_status_after_delay

  scope :saldo_day,       lambda{ |day| where('DATE(created_at) = ?', day)}
  scope :by_corporation,  lambda{ |corporation| where('corporation_id = ?', corporation)}

  def show_tarif_name
    if self.abonent_tarif.nil?
      "Not selected"
    else
      self.abonent_tarif.name
    end
  end

  def addStartDay
    self.abonent_saldos.create!(:abonent => self, :start_day => "0")
  end

  def chage_status_after_start_day
    if self.status = false and self.start_date == Date.current
      self.update_attributes(:status => true)
    end
  end

  
  def show_status
    self.status ? "Активен" : "Не активен"
  end

  def change_status_after_delay
    if !self.suspend?
      pays = self.abonent_payments.collect{|pay| pay.amount}
      debits = self.abonent_debits.collect{|pay| pay.amount}
      balance = self.abonent_saldos.last.start_day. + pays.sum - debits.sum
        if self.status == false and self.delay > 0
          self.update_attributes(:status => true)
        elsif self.status == true and self.delay == 0 and balance <= 0
          self.update_attributes(:status => false)
        end
    end
  end

  def change_delay
    update_attributes(:delay => delay - 1) if !self.suspend? and delay > 0
  end

  def charge
    if !self.suspend? and status == true
      last_debit = abonent_debits.last
      if abonent_tarif.monthly?
        if abonent_debits.last
          if last_debit.abonent_tarif.monthly? and last_debit.created_at + 30.day == Date.current
            make_debit
          elsif !last_debit.abonent_tarif.monthly?
            make_debit
          end
        else
          make_debit
        end
      else
        make_debit
      end
    end
  
#--------------------- new func -----------------------------------
# make_debit if !last_debit or 
#               (last_debit and !last_debit.abonent_tarif.monthly?) or
#               !abonent_tarif.monthly?

# make_debit if abonent_tarif.monthly? and
#               last_debit and
#               last_debit.abonent_tarif.monthly and
#               last_debit.created_at + 30.day == Date.current

  end


  def has_enough_balance
    pays = abonent_payments.collect{|pay| pay.amount}
    debits = abonent_debits.collect{|pay| pay.amount}
    balance = pays.sum - debits.sum
     
    balance < abonent_tarif.get_charge

  end

  def make_debit
    amount = abonent_tarif.get_charge
    abonent_debits.create!(:amount => amount, abonent_tarif_id: abonent_tarif.id)
  end



end

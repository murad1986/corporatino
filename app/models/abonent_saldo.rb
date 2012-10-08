class AbonentSaldo < ActiveRecord::Base
  belongs_to :abonent

  #Scope's
  scope :saldo_day, lambda{ |day| where('DATE(created_at) = ?', day)}
  scope :saldos, lambda{ |abonent, from_day, to_day| find(:all, :conditions => ['abonent_id = ? and DATE(created_at) >= ? and DATE(created_at) <= ?', abonent, from_day, to_day])}

  #scope :saldo_day, lambda{ |day|
  #  where('DATE(created_at) = ?', day).joins(:abonent).where(abonent.saldo_corporation => 10)
  #}

  def self.balance_start_day(corporation)
    @abonents = corporation.abonents
    @abonents.each do |abonent|
      payments = abonent.abonent_payments.where('DATE(created_at) = ?', Date.yesterday).map {|a| a.amount }
      debits   = abonent.abonent_debits.where('DATE(created_at) = ?', Date.yesterday).map {|a| a.amount }
      start_day = abonent.abonent_saldos.last.start_day + payments.sum - debits.sum
      abonent.abonent_saldos.create!(:start_day => start_day)
    end
  end

  def self.recalc(corporation, from_day, to_day)
    @abonents = corporation.abonents
    @abonents.each do |abonent|
    
    end
  end
end

class CorporationPayment < ActiveRecord::Base
  belongs_to :corporation

  after_save  :change_status

  scope :pays_by_day, lambda{ |day| find(:all, :conditions => ['DATE(created_at) = ?', day])}

  def change_status
    corporation_pays = self.corporation.corporation_payments.collect{|pay| pay.amount}
    corporation_debits = self.corporation.corporation_debits.collect{|pay| pay.amount}
    balance = corporation.corporation_saldos.last.startDay. + corporation_pays.sum - corporation_debits.sum
    if self.corporation.status == 0 and balance > 0
      self.corporation.update_attributes(:status => 1)
    end
  end

  def self.balance_start_day
    @abonents = Abonent.all
    @abonents.each do |abonent|

      payments = abonent.abonent_payments.where('DATE(created_at) = ?', Date.yesterday).map {|a| a.amount }
      debits = abonent.abonent_debits.where('DATE(created_at) = ?', Date.yesterday).map {|a| a.amount }
      start_day = abonent.abonent_saldos.last.start_day + payments.sum - debits.sum
      abonent.abonent_saldos.create!(:start_day => start_day)
    end
  end

end

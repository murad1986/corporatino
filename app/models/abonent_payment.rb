class AbonentPayment < ActiveRecord::Base
  belongs_to  :abonent

  after_save  :change_status
  scope :pays_by_date, lambda{ |from_day, to_day| find(:all, :conditions => ['DATE(created_at) >= ? and DATE(created_at) <= ?', from_day, to_day])}
  scope :pays_by_day, lambda{ |day| find(:all, :conditions => ['DATE(created_at) = ?', day])}

  def change_status
    if !self.abonent.suspend?
      abonent_pays = self.abonent.abonent_payments.collect{|pay| pay.amount}
      abonent_debits = self.abonent.abonent_debits.collect{|pay| pay.amount}
      balance = abonent.abonent_saldos.last.start_day + abonent_pays.sum - abonent_debits.sum
      if self.abonent.status == false and balance > 0
        self.abonent.update_attributes(:status => true)
      end
    end
  end
end

class AbonentPayment < ActiveRecord::Base
  belongs_to  :abonent

  scope :pays_by_date, lambda{ |from_day, to_day| find(:all, :conditions => ['DATE(created_at) >= ? and DATE(created_at) <= ?', from_day, to_day])}
  scope :pays_by_day, lambda{ |day| find(:all, :conditions => ['DATE(created_at) = ?', day])}

end

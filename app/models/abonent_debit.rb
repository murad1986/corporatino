class AbonentDebit < ActiveRecord::Base
  belongs_to  :abonent
  belongs_to  :abonent_tarif
  
  scope :debits_by_day, lambda{ |day| find(:all, :conditions => ['DATE(created_at) = ?', day])}

end

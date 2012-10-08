class CorporationDebit < ActiveRecord::Base
  belongs_to :corporation
  scope :debits_by_day, lambda{ |day| find(:all, :conditions => ['DATE(created_at) = ?', day])}

end

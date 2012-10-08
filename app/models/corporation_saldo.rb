class CorporationSaldo < ActiveRecord::Base
  belongs_to :corporation
  scope :saldos, lambda{ |corporation, from_day, to_day| find(:all, :conditions => ['corporation_id = ? and DATE(created_at) >= ? and DATE(created_at) <= ?', corporation, from_day, to_day])}


def self.result_table
  @reports = []
  corporations = CorporationSaldo.all
  corporations.each do |corp|
    @reports[corp.created_at.to_i] << corp.startDay
  end
  pp @reports
end
  




  def self.balance_start_day(corporation)
    payments = corporation.corporation_payments.where('DATE(created_at) = ?', Date.yesterday).map {|a| a.amount }
    debits = corporation.corporation_debits.where('DATE(created_at) = ?', Date.yesterday).map {|a| a.amount }
    start_day = corporation.corporation_saldos.last.startDay + payments.sum - debits.sum
    corporation.corporation_saldos.create!(:startDay => start_day)
  end
end

task :end_day => :environment do
  Corporation.end_day
end


task :change_status => :environment do
  Corporation.change_status_hourly
end



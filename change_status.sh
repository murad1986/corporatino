source /home/corporatino//.rvm/gems/ruby-1.9.3-p0@corporatino

if rake change_status RAILS_ENV=production; then
	echo `date +%y.%m.%d--%H:%m:%S`. Задача rake change_status: Успешно.>>cron_log.log
else
	echo `date +%y.%m.%d--%H:%m:%S`. Задача rake change_status: Ошибка!>>cron_log.log
fi

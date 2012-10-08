if rake end_day RAILS_ENV=production; then
	echo `date +%y.%m.%d--%H:%m:%S`. Задача rake end_day: Успешно>>cron_log.log
else	
	echo `date +%y.%m.%d--%H:%m:%S`. Задача rake end_day: Ошибка!>>cron_log.log
fi

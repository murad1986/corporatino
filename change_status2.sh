#!/bin/sh
source /home/corporatino//.rvm/gems/ruby-1.9.3-p0@corporatino

echo "start change status">>cron_log.log
a= rake change_status;

echo $a;

if rake change_status; then
	echo `date +%y.%m.%d--%H:%m:%S`. Задача rake change_status: Успешно.>>cron_log.log
fi

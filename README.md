Скрипт записывается в определенный каталог например /home/bash/script.sh
В crontab сделать запись, чтоб скрипт повторялся каждый час.
0 * * * * /home/bash/ script.sh
Скрипт будет запускаться каждый час и присылать информацию о IP, URL и code ответа веб сервера.

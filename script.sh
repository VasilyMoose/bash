#!/bin/bash
# путь к логам веб сервера
log_dir="/path/"
#  Место для указания временного файла для хранения результатов
temp_file="/home/bash/http_requests.tmp"
# создаем временный файл
touch $temp_file
# Получаем время последнего запуска скрипта
last_run=$(cat $temp_file)
# Создаем временный файл с текущим временем
now=$(date +%H:%M:%S)
echo $now > $temp_file
# Получаем список IP, URL и Code с количеством запросов с момента последнего запуска скрипта и сохраняем в файлы.
awk -v last_run="$last_run" '$3 > last_run {print $6}' $log_dir/nginx.log | sort | uniq -c | sort -nr | head -n 10 > ip.txt

awk -v last_run="$last_run" '$3 > last_run {print $14}' $log_dir/nginx.log | sort | uniq -c | sort -nr | head -n 10 > code.txt

cat $LOG_FILE | sed -E 's/.*"(GET|POST) ([^"]*).*/\2/' | sort | uniq -c | sort -nr | head -$NUM_URLS > url.txt
# отправляем электронную почту на адрес, что мы укажем с приложенными файлами.
to="user@domain.ru"
subject="Список IP адресов, URL и кодов ответа веб сервера"
subject="в прицепе файлы со список IP адресов, URL и кодов ответа веб сервера"

attachment1="/root/ip.txt"
attachment2="/root/code.txt"
attachment3="/root/url.txt"

echo "$body" | mail -s "$subject" "$to" -A "$attachment1 -A "$attachment2 -A "$attachment3"

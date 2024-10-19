#!/bin/bash

if systemctl is-active --quiet nginx; then
  status="ONLINE"
  message="Nginx está rodando!"
else
  status="OFFLINE"
  message="Nginx não está ativo ou está com problemas!"
fi

echo "$message"

timestamp=$(date "+%y-%m-%d %h:%m:%s")
log="$timestamp Nginx $status - $message"

if [[ $status == "ONLINE" ]]; then
  log_file="online_log.txt"
elif [[ $status == "OFFLINE" ]]; then
  log_file="offline_log.txt"
fi

if [[ -d "nginx_logs" ]]; then
  if [[ -f "nginx_logs/$log_file" ]]; then
    echo "$log" >> "nginx_logs/$log_file"
  else
    echo "$log" > "nginx_logs/$log_file"
  fi
else
  mkdir "nginx_logs"
  echo "$log" > "nginx_logs/$log_file"
fi
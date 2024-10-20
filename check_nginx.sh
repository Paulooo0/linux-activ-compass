#!/bin/bash

if systemctl is-active --quiet nginx; then
	status="ONLINE"
	colored_status="\e[32m$status\e[0m"
	message="Nginx está rodando!"
	log_file="online_log.txt"
else
	status="OFFLINE"
	colored_status="\e[31m$status\e[0m"
	message="Nginx não está ativo ou está com problemas!"
	log_file="offline_log.txt"
fi

log_dir="/var/log/nginx/"

if [[ ! -d "$log_dir" ]]; then
	echo "check_nginx: Diretório $log_dir não encontrado, nessário permissão para criar diretório"
	sudo mkdir -p "$log_dir"
	sudo chmod 755 "$log_dir"
fi

if [[ ! -w "$log_dir" ]]; then
	echo "check_nginx: Não é permitido escrita em $log_dir, necessário permissão para prosseguir"
	sudo chmod 755 "$log_dir"
fi

timestamp=$(date "+%Y-%m-%d %H:%M:%S")
log="$timestamp Nginx $colored_status - $message"
echo -e "$log" >> "$log_dir$log_file"

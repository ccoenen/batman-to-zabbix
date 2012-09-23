echo converting
ruby .\batmanconvert.rb %1

echo sending
zabbix_sender -c zabbix_sender.conf -T -i zabbix_values.txt


pause

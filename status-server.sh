#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
HOST=$(hostname)

OUTPUT="Server_Report_${HOST}_${DATE}.txt"

exec > "$OUTPUT"

echo "====================================================="
echo "SERVER REPORT"
echo "Hostname : $(hostname)"
echo "Date     : $(date)"
echo "====================================================="

echo
echo "========== OS =========="
cat /etc/os-release

echo
echo "========== KERNEL =========="
uname -a

echo
echo "========== UPTIME =========="
uptime

echo
echo "========== CPU =========="
lscpu

echo
echo "========== MEMORY =========="
free -h

echo
echo "========== SWAP =========="
swapon --show

echo
echo "========== LOAD =========="
cat /proc/loadavg

echo
echo "========== DISKS =========="
lsblk

echo
echo "========== FILESYSTEM =========="
df -hT

echo
echo "========== MOUNTS =========="
mount

echo
echo "========== NETWORK =========="
ip addr

echo
echo "========== ROUTING =========="
ip route

echo
echo "========== DNS =========="
cat /etc/resolv.conf

echo
echo "========== OPEN PORTS =========="
ss -tulnp

echo
echo "========== NETWORK CONNECTIONS =========="
ss -ant

echo
echo "========== INTERFACES =========="
ip -s link

echo
echo "========== LOGGED USERS =========="
who

echo
echo "========== LAST LOGINS =========="
last -n 20

echo
echo "========== TOP MEMORY =========="
ps aux --sort=-%mem | head -20

echo
echo "========== TOP CPU =========="
ps aux --sort=-%cpu | head -20

echo
echo "========== SERVICES =========="
systemctl --type=service --state=running

echo
echo "========== FAILED SERVICES =========="
systemctl --failed

echo
echo "========== ENABLED SERVICES =========="
systemctl list-unit-files --state=enabled

echo
echo "========== CRON =========="
crontab -l 2>/dev/null

echo
echo "========== ROOT CRON =========="
cat /etc/crontab 2>/dev/null

echo
echo "========== FIREWALL =========="
ufw status 2>/dev/null
firewall-cmd --list-all 2>/dev/null

echo
echo "========== IPTABLES =========="
iptables -L -n 2>/dev/null

echo
echo "========== JOURNAL ERRORS =========="
journalctl -p err -n 100 --no-pager

echo
echo "========== SYSLOG =========="
tail -100 /var/log/syslog 2>/dev/null

echo
echo "========== AUTH LOG =========="
tail -100 /var/log/auth.log 2>/dev/null

echo
echo "========== DOCKER =========="
docker ps -a 2>/dev/null
docker images 2>/dev/null

echo
echo "========== KUBERNETES =========="
kubectl get nodes 2>/dev/null
kubectl get pods -A 2>/dev/null

echo
echo "========== ZABBIX =========="
systemctl status zabbix-agent 2>/dev/null
systemctl status zabbix-agent2 2>/dev/null

echo
echo "========== TEMPERATURE =========="
sensors 2>/dev/null

echo
echo "========== PCI =========="
lspci

echo
echo "========== USB =========="
lsusb

echo
echo "========== DMESG LAST =========="
dmesg | tail -100

echo
echo "========== ENV =========="
env

echo
echo "========== END =========="
#!/bin/bash
# IP permitida
ip_permitida="XX.XX.XX.XX"
# Limpia la pantalla.
clear
# Borrar reglas básicas
iptables -F > /dev/null 2>&1
iptables -X > /dev/null 2>&1
# Cerrar todas las conexiones
iptables -P INPUT DROP
# Prohibición de redireccionamiento
iptables -P FORWARD DROP
# Permitir todas las conexiones salientes
iptables -P OUTPUT ACCEPT
#Permitir  conexionnes activas solicitadas al exteriro
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Permitir Puertos Solicitados - Apertura por número de puerto
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
# Apertura por número de puerto y filtro por IP
# Administracion Remota por SSH
iptables -A INPUT -s $ip_permitida -p TCP --dport 22 -j ACCEPT
# Permitir PING
iptables -A INPUT -s $ip_permitida -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A INPUT -s $ip_permitida -p icmp --icmp-type echo-request -j ACCEPT
#Permitir localhost
iptables -A INPUT -i lo -j ACCEPT
#registrar todos los eventos
iptables -A INPUT -j LOG --log-level 7 
# Fin del Script

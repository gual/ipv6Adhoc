#!/bin/bash
echo "==================================================================="
echo "== Bienvenido al script de automatización de una red IPv6 Ad-Hoc =="
echo "==================================================================="

#Ingreso de valores
echo "==================================================================="
echo "Por favor, ingrese el identificador de la interfaz inalámbrica:"
read interfaz
echo "==================================================================="
echo "Por favor, ingrese el essid deseado:"
read essid
echo "==================================================================="
echo "Por favor, ingrese el canal a utilizar:"
read canal
echo "==================================================================="
echo "Por favor, ingrese la clave a utilizar:"
read clave
echo "==================================================================="
echo "Por favor, ingrese la dirección a utilizar:"
read direccion
echo "==================================================================="
echo "Por favor, ingrese el prefijo de la dirección:"
read prefijo
echo "==================================================================="
echo "Realizando las configuraciones necesarias..."

#Configuraciones

##Para limpiar configuraciones existentes
echo "Limpiando configuraciones existentes"
estaCorriendo=$(pidof NetworkManager)
if [ $estaCorriendo -gt 0 ]; then
/etc/init.d/network-manager stop
fi
ip addr flush $interfaz
##Inhabilitación de interfaz
ifconfig $interfaz down

##Configuración de red inalámbrica
iwconfig $interfaz mode ad-hoc channel $canal essid $essid key $clave
ifconfig $interfaz up
echo "..."
##Asignación de direcciones
ifconfig $interfaz inet6 add $direccion/$prefijo
echo "==================================================================="
echo "Configuraciones exitosas... "
echo "Debe correr este script en los equipos que desee conectar a la red,"
echo "ingresando la misma información y variando solamente la dirección IP"

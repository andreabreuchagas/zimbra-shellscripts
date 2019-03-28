#!/bin/bash
#==========================================================
# Zimbra Shell Script
# zimbra_addrandomtelephoneNumber.sh
# Script to add a randon number (1 to 9999) on the
# telephoneNumber field in zimbra ldap for all the accounts.
#
# The numbers will be in sequence based on the date that the
# email was created on zimbra.
#==========================================================
# Licensed under the MIT License
# Copyright (C) 2019 André Chagas <andreabreuchagas@gmail.com>
# -
# Version 1.0
# 20190328 - Rev.00
#

echo "Obtaining zimbra accounts..."
ZMLISTAMAIL="`su - zimbra -c 'zmprov -l gaa'`";
count=0
# For each account do:

for email in $ZMLISTAMAIL; do
        count=$((count+1))
        #Set telephone to
        telephone=`seq -f "%04g" $count $count`
        executar[$count]="ma $email telephoneNumber $telephone"
done
mkdir /tmp/zimbra_addrandomtelephoneNumber
printf '%s\n' "${executar[@]}" > /tmp/zimbra_addrandomtelephoneNumber/listaaddtelephoneNumber.txt
/opt/zimbra/bin/zmprov < /tmp/zimbra_addrandomtelephoneNumber/listaaddtelephoneNumber.txt

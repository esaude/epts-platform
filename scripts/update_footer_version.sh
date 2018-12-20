#!/bin/bash

# fail on first error
set -o errexit

script=`basename $0`

if [ "$#" -ne 1 ]; then
    tput setaf 1
    echo "Missing OpenMRS war file path"
    echo "Usage: ./$script <openmrs_war_path>"
    tput setaf 7
    exit 1
fi

openmrs_war_path=`readlink -f $1`
war=`basename $openmrs_war_path`

echo 'In progress...'

mkdir /tmp/$war && unzip -q $openmrs_war_path -d /tmp/$war

sed -i "s/Powered by OpenMRS/EPTS retrospective version 2.0 - Powered by OpenMRS/g" /tmp/$war/WEB-INF/messages.properties
sed -i "s/Fornecido Por OpenMRS/EPTS retrospectivo versão 2.0 - Fornecido Por OpenMRS/g" /tmp/$war/WEB-INF/messages_pt.properties

cd /tmp/$war && fastjar cf /tmp/openmrs-patched.war -M *
mv -f /tmp/openmrs-patched.war $openmrs_war_path

rm -rf /tmp/$war

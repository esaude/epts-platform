echo 'daily list script starting';
cd /opt/sesp-repository/

mysql -uroot -ppassword -D openmrs -e "select a.identifier as NID, b.given_name as nome, b.family_name as apelido,date(c.encounter_datetime) as data_visita from patient_identifier a, person_name b, encounter c where a.patient_id = b.person_id and b.person_id = c.patient_id and a.identifier_type = 3;" > list.txt

exit
echo 'daily list script finished';
end;


select 


(select concat(count(*), ' POC')from person p inner join patient pt on p.person_id = pt.patient_id 
where p.voided=0 and pt.voided = 0
-- and p.person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
)  as reg_pat, 

(select concat(count(*), ' POC')from person p inner join patient pt on p.person_id = pt.patient_id where p.voided=0 and pt.voided = 0 and p.gender = 'M'
-- and p.person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_male,

(select concat(count(*), ' POC')from person p inner join patient pt on p.person_id = pt.patient_id where p.voided=0 and pt.voided = 0 and p.gender = 'F'
-- and p.person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_female,

(select concat(count(*), ' POC')from person p inner join patient pt on p.person_id = pt.patient_id where p.voided=0 and pt.voided = 0 
and p.birthdate is  null
-- and p.person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_no_bday,

(select concat(count(*), ' POC') from person p
   where p.voided = 0
   and (timestampdiff(YEAR, date(p.birthdate), date(now())) < 5)
    and p.birthdate is not null
   and p.person_id in (select distinct pa.person_id from person_attribute pa
where pa.person_attribute_type_id = 999)) as pat_under_five,

(select concat(count(*), ' POC')from person p where p.voided = 0
   and (timestampdiff(YEAR, date(p.birthdate), date(now())) >= 5)
   and (timestampdiff(YEAR, date(p.birthdate), date(now())) <= 15)
    and p.birthdate is not null
   and p.person_id in (select distinct pa.person_id from person_attribute pa
where pa.person_attribute_type_id = 999)) as pat_five_fifteen,

(select concat(count(*), ' POC')from person p
   where p.voided = 0
   and (timestampdiff(YEAR, date(p.birthdate), date(now())) > 15)
   and (timestampdiff(YEAR, date(p.birthdate), date(now())) <= 45)
    and p.birthdate is not null
   and p.person_id in (select distinct pa.person_id from person_attribute pa
where pa.person_attribute_type_id = 999)) as pat_sixteen_fourtysix,

(select concat(count(*), ' POC')from person p
   where p.voided = 0
   and (timestampdiff(YEAR, date(p.birthdate), date(now())) > 45)
    and p.birthdate is not null
   and p.person_id in (select distinct pa.person_id from person_attribute pa
where pa.person_attribute_type_id = 999)) as pat_over_fourtysix,

(select concat(count(*), ' POC')from openmrs.person_attribute where person_attribute_type_id = '39'
-- and person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_bi,

(select concat(count(*), ' POC') from openmrs.obs
where concept_id = 8314 and value_coded =1 
-- and person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_tb,

(select concat(count(*), ' POC') from openmrs.obs
where concept_id = 8332
-- and person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_next_cons, 

 
(select concat(count(*), ' POC') from openmrs.obs
where concept_id = 8333
-- and person_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_next_arv,


(select concat(count(*), ' POC')from openmrs.patient_status_state
where patient_state = 'INACTIVE_DEATH'
-- and patient_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_dead,

(select concat(count(*), ' POC')from openmrs.patient_status_state
where patient_state = 'INACTIVE_TRANSFERRED_OUT' 
-- and patient_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_transfer_out,

(select concat(count(*), ' POC')from openmrs.patient_status_state
where patient_state = 'TARV_ABANDONED' and patient_status = 'TARV'
-- and patient_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_abandoned_tarv,

(select concat(count(*), ' POC')from openmrs.patient_status_state
where patient_state = 'TARV_ABANDONED' and patient_status = 'Pre TARV'
-- and patient_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_abandoned_pretarv,

(select concat(count(*), ' POC')from openmrs.patient_status_state
where patient_state = 'INACTIVE_SUSPENDED'
-- and patient_id in (select distinct pa.person_id from person_attribute pa where pa.person_attribute_type_id = 999 and pa.value between 27500 and 28500)
) as pat_suspended

 from dual;


select concat(count(distinct person_id),' POC')
from obs
where concept_id = 8247;



select 

(select concat(count(*),' POC')
from openmrs.obs 
where concept_id = 8673
-- and person_id in (select person_id from person_attribute where person_attribute_type_id = 999 and value between 27500 and 28500)
) as confident_number,

(select concat(count(*),' POC')
from openmrs.obs 
where concept_id = 8672
-- and person_id in (select person_id from person_attribute where person_attribute_type_id = 999 and value between 27500 and 28500)
) as confident_name

from dual;


select 

(select concat(count(*),' POC')  
from openmrs.patient_status_state 
where patient_status ='TARV'
and id in 
(select distinct max(id) from openmrs.patient_status_state group by patient_id)
group by  patient_status) as tarv_count,

(select concat(count(*),' POC')  
from openmrs.patient_status_state 
where patient_status ='Pre Tarv'
and id in 
(select distinct max(id) from openmrs.patient_status_state group by patient_id)
group by  patient_status) as pre_tarv_count

from dual;


select case
when estadio.concept_id=8308 then 'estadio 1 poc'
when estadio.concept_id=8309 then 'estadio 2 poc'
when estadio.concept_id=8310 then 'estadio 3 poc'
when estadio.concept_id=8311 then 'estadio 4 poc'
else 'estadio xx'
end as concept_id, count(*)
from (
select p.person_id,ob.concept_id,max(ob.obs_datetime)
from 
openmrs.person p
inner join openmrs.patient pp on p.person_id =  pp.patient_id
inner join openmrs.obs ob on p.person_id = ob.person_id
where ob.concept_id in (8308,8309,8310,8311)
-- and p.person_id in (select person_id from person_attribute where value between 27500 and 28500 and attribute_type = 999)
group by p.person_id) as estadio
group by estadio.concept_id;


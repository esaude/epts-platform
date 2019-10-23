select 

(select concat(count(*),' EPTS') from person p where p.voided=0 and p.voided = 0
-- and p.person_id between 27500 and 28500 
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2)))  as reg_pat, 

(select concat(count(*),' EPTS')  from person p
where p.voided=0 and p.gender = 'M'
-- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_male,

(select concat(count(*),' EPTS')  from person p 
where p.voided=0 and p.gender = 'F'
-- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_female,

(select concat(count(*),' EPTS')  from person p
where p.voided=0
and p.birthdate is null -- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_no_bday,

(select concat(count(*),' EPTS')  from person p
where p.voided = 0
and (timestampdiff(YEAR, date(p.birthdate), date(now())) < 5)
and p.birthdate is not null
-- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_under_five,

(select concat(count(*),' EPTS')  from  person p
where p.voided = 0
and (timestampdiff(YEAR, date(p.birthdate), date(now())) >= 5)
and (timestampdiff(YEAR, date(p.birthdate), date(now())) <= 15)
and p.birthdate is not null
-- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_five_fifteen,

(select concat(count(*),' EPTS')  from person p
where p.voided = 0
and (timestampdiff(YEAR, date(p.birthdate), date(now())) > 15)
and (timestampdiff(YEAR, date(p.birthdate), date(now())) <= 45)
and p.birthdate is not null
-- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_sixteen_fourtysix,

(select concat(count(*),' EPTS')  from person p
where p.voided = 0
and (timestampdiff(YEAR, date(p.birthdate), date(now())) > 45)
and p.birthdate is not null
-- and p.person_id between 27500 and 28500
and p.person_id in (select distinct pp.patient_id from patient_program pp where pp.program_id in (1,2))) as pat_over_fourtysix,

(select concat(count(*),' EPTS') from patient_identifier pa
where pa.identifier_type = 3 
-- and pa.patient_id between 27500 and 28500
) as pat_bi,


(select concat(count(*),' EPTS')  from
(SELECT p.patient_id,o.concept_id,o.value_coded,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
        WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
-- and p.patient_id between 27500 and 28500 
and p.patient_id in (select distinct patient_id from patient_program where program_id in (1,2))
          and o.concept_id = 6257 and o.value_coded = 1065
          AND p.voided = 0
group by   p.patient_id) as tb) as pat_tb ,

(select concat(count(*),' EPTS')  from (
SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
        WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
-- and p.patient_id between 27500 and 28500
          and o.concept_id = 1410
          AND p.voided = 0
group by   p.patient_id) as next_cons) as pat_next_cons, 

 

(select concat(count(*),' EPTS')  from (
SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
        WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
-- and p.patient_id between 27500 and 28500
          and o.concept_id = 5096
          AND p.voided = 0
group by   p.patient_id) as next_tarv) as pat_next_arv,


(select concat(count(*),' EPTS')  from (
SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
        WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
-- and p.patient_id between 27500 and 28500
          and o.concept_id = 856
          AND p.voided = 0
group by   p.patient_id) as carga_viral) as pat_carga_viral,

(select concat(count(*),' EPTS')  from (
SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
        WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
-- and p.patient_id between 27500 and 28500
          and o.concept_id = 6128
          AND p.voided = 0
group by   p.patient_id) as inh) as pat_inh,

(select concat(count(*),' EPTS')  from (
select
distinct p.patient_id, program.program_id,max(program.state_id)
from patient p
inner join 
(select pp.patient_id, pp.patient_program_id,state.state_id, program_id
from patient_program pp 
inner join 
(select patient_program_id, max(patient_state_id) state_id 
from patient_state 
where state in (5,10) group by patient_program_id) state on state.patient_program_id = pp.patient_program_id 
where pp.program_id in (1,2) and pp.voided=0) program on program.patient_id = p.patient_id
where p.voided=0 -- and p.patient_id between 27500 and 28500
group by p.patient_id) states) as pat_dead,


(select concat(count(*),' EPTS')  from (
select
distinct p.patient_id, program.program_id,max(program.state_id)
from patient p
inner join 
(select pp.patient_id, pp.patient_program_id,state.state_id, program_id
from patient_program pp 
inner join 
(select patient_program_id, max(patient_state_id) state_id 
from patient_state 
where state in (3,7) group by patient_program_id) state on state.patient_program_id = pp.patient_program_id 
where pp.program_id in (1,2) and pp.voided=0) program on program.patient_id = p.patient_id
where p.voided=0 -- and p.patient_id between 27500 and 28500
group by p.patient_id) states) as pat_transfer_out,


((select concat(count(*),' EPTS') from 
(-- TARV patient voided = 0
select p.patient_id, pp3.max_patient_state_id, pp3.state
from
(select pp2.patient_id, pp2.max_patient_state_id, ps2.state
from (
select pp.patient_id, max(ps.patient_state_id) as max_patient_state_id
from
(select patient_program_id, patient_id, program_id
from patient_program
where program_id = 2
-- and patient_id between 27500 and 28500
and voided = 0) as pp, patient_state as ps
where ps.patient_program_id = pp.patient_program_id
group by pp.patient_id) as pp2, patient_state as ps2
where pp2.max_patient_state_id = ps2.patient_state_id
and ps2.state = 9) as pp3, patient as p
where pp3.patient_id = p.patient_id
and p.voided = 0) as tarv)) as pat_abandoned_tarv,

((select concat(count(*),' EPTS') from 
(-- Pre TARV patient voided = 0 Abandono
select p.patient_id, pp3.max_patient_state_id, pp3.state
from
(select pp2.patient_id, pp2.max_patient_state_id, ps2.state
from (
select pp.patient_id, max(ps.patient_state_id) as max_patient_state_id
from
(select patient_program_id, patient_id, program_id
from patient_program
where program_id = 1
-- and patient_id between 27500 and 28500
and patient_id not in (select pp.patient_id
from patient_program pp
where pp.program_id = 2 and pp.voided=0
-- and pp.patient_id in (select distinct patient_id from patient where voided =0 and patient_id between 27500 and 28500)
group by pp.patient_id)
and voided = 0) as pp, patient_state as ps
where ps.patient_program_id = pp.patient_program_id
group by pp.patient_id) as pp2, patient_state as ps2
where pp2.max_patient_state_id = ps2.patient_state_id) as pp3, patient as p
where pp3.patient_id = p.patient_id and pp3.state = 2
and p.voided = 0) as pre_tarv)
) as pat_abandoned_pretarv,

(select concat(count(*),' EPTS')  from (
select
distinct p.patient_id, program.program_id,max(program.state_id)
from patient p
inner join 
(select pp.patient_id, pp.patient_program_id,state.state_id, program_id
from patient_program pp 
inner join 
(select patient_program_id, max(patient_state_id) state_id 
from patient_state 
where state = 8 group by patient_program_id) state on state.patient_program_id = pp.patient_program_id 
where pp.program_id in (1,2) and pp.voided=0) program on program.patient_id = p.patient_id
where p.voided=0 -- and p.patient_id between 27500 and 28500
group by p.patient_id,program.program_id) states) as pat_suspended


 from dual;

 select 

concat(count(pat_regime.patient_id),' EPTS') 

from (
SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id AND e.location_id=208 AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  AND o.location_id=208 AND o.voided = 0
        WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
-- and p.patient_id between 27500 and 28500
          and o.concept_id = 1255 and o.value_coded=1259
and e.encounter_id in (select distinct encounter_id from obs where person_id = o.person_id 
and concept_id = 1087 and value_coded is not null)
          AND p.voided = 0
group by   p.patient_id) as pat_regime;

select 
(select
concat(count(*),' EPTS') from (
SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
          WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
          -- and p.patient_id between 27500 and 28500
          and o.concept_id =1611
          AND p.voided = 0
          group by   p.patient_id) as confident_number) as confident_number,

(select concat(count(*),' EPTS') from
(SELECT p.patient_id,o.concept_id,max(e.encounter_datetime) as last_datetime
        FROM patient p
          INNER JOIN encounter e ON e.patient_id = p.patient_id 
-- AND e.location_id=208 
AND e.voided = 0
          INNER JOIN obs o ON o.encounter_id = e.encounter_id  
-- AND o.location_id=208 
AND o.voided = 0
          WHERE p.voided = 0 AND e.voided = 0 AND o.voided=0
          AND e.encounter_type IN (1,6,13,35,34,5,18,3,7,9)
          -- and p.patient_id between 27500 and 28500
          and o.concept_id = 1740
          AND p.voided = 0
          group by   p.patient_id) as confident_name) as confident_name

from dual;

select 
(
select concat(count(*),' EPTS') from
(select pp.patient_id, pp.program_id,max(pp.patient_program_id) 
from patient_program pp
where pp.program_id = 2 and pp.voided=0  -- and pp.patient_id between 27500 and 28500
-- and pp.patient_id in (select distinct patient_id from patient where voided =0 and patient_id between 27500 and 28500)
group by pp.patient_id) tarv ) as tarv_count,

(select concat(count(*),' EPTS') from
(select pp.patient_id, pp.program_id,max(pp.patient_program_id)
from patient_program pp
where pp.program_id = 1 and pp.voided=0  -- and pp.patient_id between 27500 and 28500
and pp.patient_id  not in (select pp.patient_id
from patient_program pp 
where pp.program_id = 2 and pp.voided=0  -- and pp.patient_id between 27500 and 28500
-- and pp.patient_id in (select distinct patient_id from patient where voided =0 and patient_id between 27500 and 28500)
group by pp.patient_id)
-- and pp.patient_id in (select distinct patient_id from patient where voided =0 and patient_id between 27500 and 28500)
group by pp.patient_id) pre_tarv
) as pre_tarv_count

from dual;


 select  case
when last_encounter.value_coded=1204 then 'estadio 1 epts'
when last_encounter.value_coded=1205 then 'estadio 2 epts'
when last_encounter.value_coded=1206 then 'estadio 3 epts'
when last_encounter.value_coded=1207 then 'estadio 4 epts'
else 'estadio xx'
end as value_coded, count(*) 
from (
  SELECT o.person_id, o.value_coded, max(e.encounter_datetime)
FROM obs o
INNER JOIN encounter e ON o.encounter_id = e.encounter_id
INNER JOIN patient p ON o.person_id = p.patient_id
WHERE (o.value_coded IN (1204,1205,1206,1207))
    AND (o.voided = 0)
   -- AND (o.person_id between 27500 and 28500)
   -- AND (o.location_id = 208)
   AND (e.encounter_type IN (1,6,13,35,34,5,18,3,7,9))
   -- AND (e.location_id = 208)
   AND (e.voided = 0)
   AND (p.voided = 0)
   AND (p.patient_id IN (SELECT DISTINCT pp.patient_id from patient_program pp where pp.program_id IN (1,2)))
GROUP BY o.person_id) as last_encounter
group by value_coded;
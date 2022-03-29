set search_path to mimiciii;

drop materialized view if exists icd_proc_data;
create materialized view icd_proc_data as
  
select p.subject_id
	, p.hadm_id
	, p.seq_num
	, p.icd9_code
	, d.short_title
	, d.long_title
from procedures_icd p
left join d_icd_procedures d
on p.icd9_code = d.icd9_code 
;
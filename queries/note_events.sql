set search_path to mimiciii;

drop materialized view if exists note_filter;
create materialized view note_filter as

select n.subject_id, n.hadm_id, ad.admittime, ad.dischtime, ad.deathtime
  , ie.first_careunit, ie.last_careunit
  , extract(epoch from (ad.admittime - p.dob))/60.0/60.0/24.0/365.242 as age
  , p.gender as gender
  , ad.marital_status as marital_status
  , ad.insurance as insurance
  , ad.diagnosis
  , n."text"
  , n."iserror" 
  from noteevents n 
    inner join patients p
    on n.subject_id = p.subject_id
    inner join admissions ad
    on n.hadm_id = ad.hadm_id
    left join icustays ie
    on n.hadm_id = ie.hadm_id
  -- we select only patients older than 18
  where (extract(epoch from (ad.admittime - p.dob))/60.0/60.0/24.0/365.242) > 18
  -- and get only discharge summaries
  and n.category = 'Discharge summary'
     
  ;


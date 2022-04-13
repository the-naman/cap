--create/updating task

CREATE TASK loan_task
  WAREHOUSE = my_compute_warehouse
  SCHEDULE = '1 minute'
WHEN
  SYSTEM$STREAM_HAS_DATA('loan_check')
AS
merge into loan_target t
using loan_check s
on t.id=s.id and (metadata$action='DELETE')
when matched and metadata$isupdate='FALSE' then update set rec_version=9999, stream_type='DELETE'
when matched and metadata$isupdate='TRUE' then update set rec_version=rec_version-1
when not matched then insert  (ID ,year,loan_limit ,Gender ,approv_in_adv ,loan_purpose ,Credit_Worthiness ,open_credit ,business_or_commercial ,loan_amount ,rate_of_interest ,Interest_rate_spread,Upfront_charges,term ,Neg_ammortization ,interest_only,lump_sum_payment,property_value ,Secured_by ,total_units,income ,credit_type ,Credit_Score,co_applicant_credit_type,age ,LTV,Region,Security_Type,Status,dtir1,stream_type,rec_version,REC_DATE) values(s.id, s.year,s.loan_limit ,s.Gender ,s.approv_in_adv ,s.loan_purpose ,s.Credit_Worthiness ,s.open_credit ,s.business_or_commercial ,s.loan_amount ,s.rate_of_interest ,s.Interest_rate_spread,s.Upfront_charges,s.term ,s.Neg_ammortization ,s.interest_only,s.lump_sum_payment,s.property_value ,s.Secured_by ,s.total_units,s.income ,s.credit_type ,s.Credit_Score,s.co_applicant_credit_type,s.age ,s.LTV,s.Region,s.Security_Type,s.Status,s.dtir1, metadata$action,0,CURRENT_TIMESTAMP() );
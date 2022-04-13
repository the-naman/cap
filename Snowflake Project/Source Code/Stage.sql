-- creation of external stage
create or replace stage sf_project.itr_rds_landing.my_ext_stage
storage_integration = s3_int_obj
url = 's3://flatbucket5'
file_format = (type = csv field_delimiter=',' skip_header = 1 null_if = ('NULL','null') empty_field_as_null = true  field_optionally_enclosed_by='"');
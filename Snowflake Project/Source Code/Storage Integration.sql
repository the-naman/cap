-- creation of intigration object
create or replace storage integration s3_int_obj
  type = external_stage
  storage_provider = s3
  enabled = true
  storage_aws_role_arn = 'arn:aws:iam::874545814278:role/flatbucket5_policy_role'
  storage_allowed_locations = ('s3://flatbucket5/');
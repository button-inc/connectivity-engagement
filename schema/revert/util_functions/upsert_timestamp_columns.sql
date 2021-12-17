-- Revert connectivity_engagement:util_functions/upsert_timestamp_columns from pg

begin;

drop function connectivity_engagement_private.upsert_timestamp_columns(text,text,boolean,boolean,boolean,text,text);

commit;

-- Verify connectivity_engagement:database_functions/read_only_user_policies on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.read_only_user_policies(text,text)'::regprocedure);

rollback;

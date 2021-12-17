-- Verify connectivity_engagement:database_functions/verify_policy on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.verify_policy(text,text,text,text,text)'::regprocedure);

rollback;

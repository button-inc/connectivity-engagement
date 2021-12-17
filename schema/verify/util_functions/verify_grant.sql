-- Verify connectivity_engagement:database_functions/verify_grants on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.verify_grant(text,text,text,text)'::regprocedure);
select pg_get_functiondef('connectivity_engagement_private.verify_grant(text,text,text,text[],text)'::regprocedure);

rollback;

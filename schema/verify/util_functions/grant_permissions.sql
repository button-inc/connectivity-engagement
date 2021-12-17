-- Verify connectivity_engagement:database_functions/grant_permissions on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.grant_permissions(text,text,text,text)'::regprocedure);
select pg_get_functiondef('connectivity_engagement_private.grant_permissions(text,text,text,text[],text)'::regprocedure);

rollback;

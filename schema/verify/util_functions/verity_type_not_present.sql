-- Verify connectivity_engagement:database_functions/verify_type_not_present on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.verify_type_not_present(text)'::regprocedure);

rollback;

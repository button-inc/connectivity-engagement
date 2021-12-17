-- Verify connectivity_engagement:functions/session on pg

begin;

select pg_get_functiondef('connectivity_engagement.session()'::regprocedure);

rollback;

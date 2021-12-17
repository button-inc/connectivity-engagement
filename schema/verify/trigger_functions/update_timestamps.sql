-- Verify connectivity_engagement:function_update_timestamps on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.update_timestamps()'::regprocedure);

rollback;

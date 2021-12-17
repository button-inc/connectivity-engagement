-- Verify connectivity_engagement:function_set_user_id on pg

begin;

select pg_get_functiondef('connectivity_engagement_private.set_user_id()'::regprocedure);

rollback;

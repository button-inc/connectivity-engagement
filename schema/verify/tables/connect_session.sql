-- Verify connectivity_engagement:tables/connect_session on pg

begin;

select pg_catalog.has_table_privilege('connectivity_engagement_private.connect_session', 'select');

rollback;

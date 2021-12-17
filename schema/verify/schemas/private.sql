-- Verify connectivity_engagement:schema/connectivity_engagement_private on pg

begin;

select pg_catalog.has_schema_privilege('connectivity_engagement_private', 'usage');

rollback;

-- Verify connectivity_engagement:schema/connectivity_engagement on pg

begin;

select pg_catalog.has_schema_privilege('connectivity_engagement', 'usage');

rollback;

begin;
select plan(2);

select has_schema('connectivity_engagement');
select matches(obj_description('connectivity_engagement'::regnamespace, 'pg_namespace'), '.+', 'Schema connectivity_engagement has a description');

select finish();
rollback;

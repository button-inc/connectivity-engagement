begin;
select plan(2);

select has_schema('connectivity_engagement_private');
select matches(obj_description('connectivity_engagement_private'::regnamespace, 'pg_namespace'), '.+', 'Schema connectivity_engagement_private has a description');

select finish();
rollback;

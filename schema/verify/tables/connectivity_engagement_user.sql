-- Verify connectivity_engagement:tables/connectivity_engagement_user on pg

begin;

select pg_catalog.has_table_privilege('connectivity_engagement.connectivity_engagement_user', 'select');


-- connectivity_engagement_admin Grants
select connectivity_engagement_private.verify_grant('select', 'connectivity_engagement_user', 'connectivity_engagement_internal');
select connectivity_engagement_private.verify_grant('insert', 'connectivity_engagement_user', 'connectivity_engagement_internal');
select connectivity_engagement_private.verify_grant('update', 'connectivity_engagement_user', 'connectivity_engagement_internal',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);

-- connectivity_engagement_admin Grants
select connectivity_engagement_private.verify_grant('select', 'connectivity_engagement_user', 'connectivity_engagement_external');
select connectivity_engagement_private.verify_grant('insert', 'connectivity_engagement_user', 'connectivity_engagement_external');
select connectivity_engagement_private.verify_grant('update', 'connectivity_engagement_user', 'connectivity_engagement_external',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);

-- connectivity_engagement_admin Grants
select connectivity_engagement_private.verify_grant('select', 'connectivity_engagement_user', 'connectivity_engagement_admin');
select connectivity_engagement_private.verify_grant('insert', 'connectivity_engagement_user', 'connectivity_engagement_admin');
select connectivity_engagement_private.verify_grant('update', 'connectivity_engagement_user', 'connectivity_engagement_admin',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);


-- connectivity_engagement_guest grant
select connectivity_engagement_private.verify_grant('select', 'connectivity_engagement_user', 'connectivity_engagement_guest');

rollback;

begin;

select plan(5);

select has_function('connectivity_engagement_private', 'read_only_user_policies', 'function connectivity_engagement_private.read_only_user_policies exists');
create role test_role;

select connectivity_engagement_private.read_only_user_policies('test_role');

select is(
  (select connectivity_engagement_private.verify_policy('select', 'test_role_select_connectivity_engagement_user', 'connectivity_engagement_user', 'test_role')),
  true,
  'test_role_select_connectivity_engagement_user policy is created'
);

select throws_like(
  $$select connectivity_engagement_private.verify_policy('insert', 'test_role_insert_connectivity_engagement_user', 'connectivity_engagement_user', 'test_role')$$,
  'Policy % does not exist',
  'test_role_insert_connectivity_engagement_user policy is not created'
);

select throws_like(
  $$select connectivity_engagement_private.verify_policy('update', 'test_role_update_connectivity_engagement_user', 'connectivity_engagement_user', 'test_role')$$,
  'Policy % does not exist',
  'test_role_update_connectivity_engagement_user policy is not created'
);

select throws_like(
  $$select connectivity_engagement_private.verify_policy('delete', 'test_delete_select_connectivity_engagement_user', 'connectivity_engagement_user', 'test_role')$$,
  'Policy % does not exist',
  'test_role_delete_connectivity_engagement_user policy is not created'
);

rollback;

begin;
select plan(11);

-- Test setup
create table connectivity_engagement.test_table
(
  id integer primary key generated always as identity
);

create table connectivity_engagement.test_table_specific_column_grants
(
  id integer primary key generated always as identity,
  allowed text,
  denied text
);

select has_function(
  'connectivity_engagement_private', 'grant_permissions',
  'Function grant_permissions should exist'
);

select throws_ok(
  $$
    select connectivity_engagement_private.grant_permissions('badoperation', 'test_table', 'connectivity_engagement_admin');
  $$,
  'P0001',
  'invalid operation variable. Must be one of [select, insert, update, delete]',
  'Function grant_permissions throws an exception if the operation variable is not in (select, insert, update, delete)'
);

select table_privs_are (
  'connectivity_engagement',
  'test_table',
  'connectivity_engagement_admin',
  ARRAY[]::text[],
  'role connectivity_engagement_admin has not yet been granted any privileges on connectivity_engagement.test_table'
);

select lives_ok(
  $$
    select connectivity_engagement_private.grant_permissions('select', 'test_table', 'connectivity_engagement_admin');
  $$,
  'Function grants select'
);

select lives_ok(
  $$
    select connectivity_engagement_private.grant_permissions('insert', 'test_table', 'connectivity_engagement_admin');
  $$,
  'Function grants insert'
);

select lives_ok(
  $$
    select connectivity_engagement_private.grant_permissions('update', 'test_table', 'connectivity_engagement_admin');
  $$,
  'Function grants update'
);

select lives_ok(
  $$
    select connectivity_engagement_private.grant_permissions('delete', 'test_table', 'connectivity_engagement_admin');
  $$,
  'Function grants delete'
);

select table_privs_are (
  'connectivity_engagement',
  'test_table',
  'connectivity_engagement_admin',
  ARRAY['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
  'role connectivity_engagement_admin has been granted select, insert, update, delete on connectivity_engagement.test_table'
);

select any_column_privs_are (
  'connectivity_engagement',
  'test_table_specific_column_grants',
  'connectivity_engagement_admin',
  ARRAY[]::text[],
  'role connectivity_engagement_admin has not yet been granted any privileges on columns in connectivity_engagement.test_table_specific_column_grants'
);

select lives_ok(
  $$
    select connectivity_engagement_private.grant_permissions('select', 'test_table_specific_column_grants', 'connectivity_engagement_admin', ARRAY['allowed']);
  $$,
  'Function grants select when specific columns are specified'
);

select column_privs_are (
  'connectivity_engagement',
  'test_table_specific_column_grants',
  'allowed',
  'connectivity_engagement_admin',
  ARRAY['SELECT'],
  'connectivity_engagement_admin has privilege SELECT only on column `allowed` in test_table_specific_column_grants'
);

select finish();
rollback;

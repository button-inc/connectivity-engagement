begin;
select plan(20);

create table connectivity_engagement.test_table_all_columns
(
  id integer primary key generated always as identity,
  test_name text
);

create table connectivity_engagement.test_table_false_columns
(
  id integer primary key generated always as identity,
  test_name text
);

select has_function(
  'connectivity_engagement_private', 'upsert_timestamp_columns',
  'Function upsert_timestamp_columns should exist'
);

select connectivity_engagement_private.upsert_timestamp_columns(
  table_schema_name := 'connectivity_engagement',
  table_name := 'test_table_all_columns',
  add_create := true,
  add_update := true,
  add_delete := true);

-- created_*, updated_*, deleted_* columns exist
select has_column('connectivity_engagement', 'test_table_all_columns', 'created_by', 'created_by column was created');
select has_column('connectivity_engagement', 'test_table_all_columns', 'created_at', 'created_at column was created');
select has_column('connectivity_engagement', 'test_table_all_columns', 'created_by', 'updated_by column was created');
select has_column('connectivity_engagement', 'test_table_all_columns', 'created_at', 'updated_at column was created');
select has_column('connectivity_engagement', 'test_table_all_columns', 'created_by', 'deleted_by column was created');
select has_column('connectivity_engagement', 'test_table_all_columns', 'created_at', 'deleted_at column was created');

-- *_by columns are foreign keys
select col_is_fk(
  'connectivity_engagement', 'test_table_all_columns', 'created_by',
  'test_table_all_columns has foreign key created_by'
);

select col_is_fk(
  'connectivity_engagement', 'test_table_all_columns', 'updated_by',
  'test_table_all_columns has foreign key updated_by'
);

select col_is_fk(
  'connectivity_engagement', 'test_table_all_columns', 'deleted_by',
  'test_table_all_columns has foreign key deleted_by'
);

-- Indices exist
select has_index(
  'connectivity_engagement', 'test_table_all_columns', 'connectivity_engagement_test_table_all_columns_created_by_foreign_key',
  'test_table_all_columns has an index on created_by fk'
);

select has_index(
  'connectivity_engagement', 'test_table_all_columns', 'connectivity_engagement_test_table_all_columns_updated_by_foreign_key',
  'test_table_all_columns has an index on updated_by fk'
);

select has_index(
  'connectivity_engagement', 'test_table_all_columns', 'connectivity_engagement_test_table_all_columns_deleted_by_foreign_key',
  'test_table_all_columns has an index on deleted_by fk'
);

set client_min_messages to warning;
select lives_ok(
  $$
    select connectivity_engagement_private.upsert_timestamp_columns(
      table_schema_name := 'connectivity_engagement',
      table_name := 'test_table_all_columns',
      add_create := true,
      add_update := true,
      add_delete := true
    );
  $$,
  'upsert_timestamp_columns does not throw an error when run a second time (idempotent)'
);
reset client_min_messages;

select connectivity_engagement_private.upsert_timestamp_columns(
  table_schema_name := 'connectivity_engagement',
  table_name := 'test_table_false_columns',
  add_create := true,
  add_update := false,
  add_delete := false);

select hasnt_column('connectivity_engagement', 'test_table_false_columns', 'updated_by', 'updated_by column is not created when parameter is set to false');
select hasnt_column('connectivity_engagement', 'test_table_false_columns', 'updated_at', 'updated_at column is not created when parameter is set to false');
select hasnt_column('connectivity_engagement', 'test_table_false_columns', 'deleted_by', 'deleted_by column is not created when parameter is set to false');
select hasnt_column('connectivity_engagement', 'test_table_false_columns', 'deleted_at', 'deleted_at column is not created when parameter is set to false');

select hasnt_index(
  'connectivity_engagement', 'test_table_false_columns', 'connectivity_engagement_test_table_false_columns_updated_by_foreign_key',
  'test_table_false_columns does not create an index updated_by parameter is false'
);

select hasnt_index(
  'connectivity_engagement', 'test_table_false_columns', 'connectivity_engagement_test_table_false_columns_deleted_by_foreign_key',
  'test_table_false_columns does not create an index when deleted_by parameter is false'
);

select finish();
rollback;

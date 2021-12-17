begin;
select plan(34);

select has_table('connectivity_engagement', 'connectivity_engagement_user', 'table connectivity_engagement.connectivity_engagement_user exists');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'id', 'table connectivity_engagement.connectivity_engagement_user has id column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'first_name', 'table connectivity_engagement.connectivity_engagement_user has first_name column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'last_name', 'table connectivity_engagement.connectivity_engagement_user has last_name column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'email_address', 'table connectivity_engagement.connectivity_engagement_user has email_address column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'uuid', 'table connectivity_engagement.connectivity_engagement_user has uuid column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'created_at', 'table connectivity_engagement.connectivity_engagement_user has created_at column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'updated_at', 'table connectivity_engagement.connectivity_engagement_user has updated_at column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'deleted_at', 'table connectivity_engagement.connectivity_engagement_user has deleted_at column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'created_by', 'table connectivity_engagement.connectivity_engagement_user has created_by column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'updated_by', 'table connectivity_engagement.connectivity_engagement_user has updated_by column');
select has_column('connectivity_engagement', 'connectivity_engagement_user', 'deleted_by', 'table connectivity_engagement.connectivity_engagement_user has deleted_by column');


insert into connectivity_engagement.connectivity_engagement_user
  (first_name, last_name, email_address, uuid) values
  ('foo1', 'bar', 'foo1@bar.com', '11111111-1111-1111-1111-111111111112'),
  ('foo2', 'bar', 'foo2@bar.com', '11111111-1111-1111-1111-111111111113'),
  ('foo3', 'bar', 'foo3@bar.com', '11111111-1111-1111-1111-111111111114');

-- Row level security tests --

-- Test setup
set jwt.claims.sub to '11111111-1111-1111-1111-111111111111';

-- connectivity_engagement_admin
set role connectivity_engagement_admin;
select concat('current user is: ', (select current_user));

select lives_ok(
  $$
    select * from connectivity_engagement.connectivity_engagement_user
  $$,
    'connectivity_engagement_admin can view all data in connectivity_engagement_user table'
);

select lives_ok(
  $$
    insert into connectivity_engagement.connectivity_engagement_user (uuid, first_name, last_name) values ('11111111-1111-1111-1111-111111111111'::uuid, 'test', 'testerson');
  $$,
    'connectivity_engagement_admin can insert data in connectivity_engagement_user table'
);

select lives_ok(
  $$
    update connectivity_engagement.connectivity_engagement_user set first_name = 'changed by admin' where uuid='11111111-1111-1111-1111-111111111111'::uuid;
  $$,
    'connectivity_engagement_admin can change data in connectivity_engagement_user table'
);

select results_eq(
  $$
    select count(uuid) from connectivity_engagement.connectivity_engagement_user where first_name = 'changed by admin'
  $$,
    ARRAY[1::bigint],
    'Data was changed by connectivity_engagement_admin'
);

select throws_like(
  $$
    update connectivity_engagement.connectivity_engagement_user set uuid = 'ca716545-a8d3-4034-819c-5e45b0e775c9' where uuid = '11111111-1111-1111-1111-111111111111'::uuid;
  $$,
    'permission denied%',
    'connectivity_engagement_admin can not change data in the uuid column in connectivity_engagement_user table'
);

select throws_like(
  $$
    delete from connectivity_engagement.connectivity_engagement_user where id=1
  $$,
  'permission denied%',
    'Administrator cannot delete rows from table connectivity_engagement_user'
);


-- connectivity_engagement_internal
set role connectivity_engagement_internal;
select concat('current user is: ', (select current_user));

select results_eq(
  $$
    select count(*) from connectivity_engagement.connectivity_engagement_user
  $$,
  ARRAY['4'::bigint],
    'connectivity_engagement_internal can view all data from connectivity_engagement_user'
);

select lives_ok(
  $$
    update connectivity_engagement.connectivity_engagement_user set first_name = 'doood' where uuid=(select sub from connectivity_engagement.session())
  $$,
    'connectivity_engagement_internal can update data if their uuid matches the uuid of the row'
);

select results_eq(
  $$
    select first_name from connectivity_engagement.connectivity_engagement_user where uuid=(select sub from connectivity_engagement.session())
  $$,
  ARRAY['doood'::varchar(1000)],
    'Data was changed by connectivity_engagement_internal'
);

select throws_like(
  $$
    update connectivity_engagement.connectivity_engagement_user set uuid = 'ca716545-a8d3-4034-819c-5e45b0e775c9' where uuid!=(select sub from connectivity_engagement.session())
  $$,
  'permission denied%',
    'connectivity_engagement_internal cannot update their uuid'
);

select throws_like(
  $$
    delete from connectivity_engagement.connectivity_engagement_user where id=1
  $$,
  'permission denied%',
    'connectivity_engagement_internal cannot delete rows from table_connectivity_engagement_user'
);

-- Try to update user data where uuid does not match
update connectivity_engagement.connectivity_engagement_user set first_name = 'buddy' where uuid!=(select sub from connectivity_engagement.session());

select is_empty(
  $$
    select * from connectivity_engagement.connectivity_engagement_user where first_name='buddy'
  $$,
    'connectivity_engagement_internal cannot update data if their uuid does not match the uuid of the row'
);

-- connectivity_engagement_external
set role connectivity_engagement_external;
select concat('current user is: ', (select current_user));

select results_eq(
  $$
    select count(*) from connectivity_engagement.connectivity_engagement_user
  $$,
  ARRAY['4'::bigint],
    'connectivity_engagement_external can view all data from connectivity_engagement_user'
);

select lives_ok(
  $$
    update connectivity_engagement.connectivity_engagement_user set first_name = 'doood' where uuid=(select sub from connectivity_engagement.session())
  $$,
    'connectivity_engagement_external can update data if their uuid matches the uuid of the row'
);

select results_eq(
  $$
    select first_name from connectivity_engagement.connectivity_engagement_user where uuid=(select sub from connectivity_engagement.session())
  $$,
  ARRAY['doood'::varchar(1000)],
    'Data was changed by connectivity_engagement_external'
);

select throws_like(
  $$
    update connectivity_engagement.connectivity_engagement_user set uuid = 'ca716545-a8d3-4034-819c-5e45b0e775c9' where uuid!=(select sub from connectivity_engagement.session())
  $$,
  'permission denied%',
    'connectivity_engagement_external cannot update their uuid'
);

select throws_like(
  $$
    delete from connectivity_engagement.connectivity_engagement_user where id=1
  $$,
  'permission denied%',
    'connectivity_engagement_external cannot delete rows from table_connectivity_engagement_user'
);

-- Try to update user data where uuid does not match
update connectivity_engagement.connectivity_engagement_user set first_name = 'buddy' where uuid!=(select sub from connectivity_engagement.session());

select is_empty(
  $$
    select * from connectivity_engagement.connectivity_engagement_user where first_name='buddy'
  $$,
    'connectivity_engagement_external cannot update data if their uuid does not match the uuid of the row'
);


-- connectivity_engagement_guest
set role connectivity_engagement_guest;
select concat('current user is: ', (select current_user));

select results_eq(
  $$
    select uuid from connectivity_engagement.connectivity_engagement_user
  $$,
  ARRAY['11111111-1111-1111-1111-111111111111'::uuid],
    'connectivity_engagement_guest can only select their own user'
);

select throws_like(
  $$
    update connectivity_engagement.connectivity_engagement_user set uuid = 'ca716545-a8d3-4034-819c-5e45b0e775c9' where uuid!=(select sub from connectivity_engagement.session())
  $$,
  'permission denied%',
    'connectivity_engagement_guest cannot update their uuid'
);

select throws_like(
  $$
    insert into connectivity_engagement.connectivity_engagement_user (uuid, first_name, last_name) values ('21111111-1111-1111-1111-111111111111'::uuid, 'test', 'testerson');
  $$,
  'permission denied%',
  'connectivity_engagement_guest cannot insert'
);

select throws_like(
  $$
    delete from connectivity_engagement.connectivity_engagement_user where id=1
  $$,
  'permission denied%',
    'connectivity_engagement_guest cannot delete rows from table_connectivity_engagement_user'
);

select finish();
rollback;

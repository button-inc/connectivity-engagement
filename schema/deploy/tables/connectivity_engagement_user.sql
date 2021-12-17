-- Deploy connectivity_engagement:tables/connectivity_engagement_user to pg

begin;
create table connectivity_engagement.connectivity_engagement_user
(
  id integer primary key generated always as identity,
  uuid uuid not null,
  first_name varchar(1000),
  last_name varchar(1000),
  email_address varchar(1000)
);

select connectivity_engagement_private.upsert_timestamp_columns('connectivity_engagement', 'connectivity_engagement_user');

create unique index connectivity_engagement_user_uuid on connectivity_engagement.connectivity_engagement_user(uuid);

do
$grant$
begin

-- Grant connectivity_engagement_internal permissions
perform connectivity_engagement_private.grant_permissions('select', 'connectivity_engagement_user', 'connectivity_engagement_internal');
perform connectivity_engagement_private.grant_permissions('insert', 'connectivity_engagement_user', 'connectivity_engagement_internal');
perform connectivity_engagement_private.grant_permissions('update', 'connectivity_engagement_user', 'connectivity_engagement_internal',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);

-- Grant connectivity_engagement_external permissions
perform connectivity_engagement_private.grant_permissions('select', 'connectivity_engagement_user', 'connectivity_engagement_external');
perform connectivity_engagement_private.grant_permissions('insert', 'connectivity_engagement_user', 'connectivity_engagement_external');
perform connectivity_engagement_private.grant_permissions('update', 'connectivity_engagement_user', 'connectivity_engagement_external',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);

-- Grant connectivity_engagement_admin permissions
perform connectivity_engagement_private.grant_permissions('select', 'connectivity_engagement_user', 'connectivity_engagement_admin');
perform connectivity_engagement_private.grant_permissions('insert', 'connectivity_engagement_user', 'connectivity_engagement_admin');
perform connectivity_engagement_private.grant_permissions('update', 'connectivity_engagement_user', 'connectivity_engagement_admin',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);


-- Grant connectivity_engagement_guest permissions
perform connectivity_engagement_private.grant_permissions('select', 'connectivity_engagement_user', 'connectivity_engagement_guest');

end
$grant$;

-- Enable row-level security
alter table connectivity_engagement.connectivity_engagement_user enable row level security;

do
$policy$
begin
-- connectivity_engagement_admin RLS
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_admin_select_connectivity_engagement_user', 'connectivity_engagement_user', 'select', 'connectivity_engagement_admin', 'true');
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_admin_insert_connectivity_engagement_user', 'connectivity_engagement_user', 'insert', 'connectivity_engagement_admin', 'true');
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_admin_update_connectivity_engagement_user', 'connectivity_engagement_user', 'update', 'connectivity_engagement_admin', 'true');



-- connectivity_engagement_internal RLS: can see all users, but can only modify its own record
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_internal_select_connectivity_engagement_user', 'connectivity_engagement_user', 'select', 'connectivity_engagement_internal', 'true');
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_internal_insert_connectivity_engagement_user', 'connectivity_engagement_user', 'insert', 'connectivity_engagement_internal', 'uuid=(select sub from connectivity_engagement.session())');
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_internal_update_connectivity_engagement_user', 'connectivity_engagement_user', 'update', 'connectivity_engagement_internal', 'uuid=(select sub from connectivity_engagement.session())');

-- connectivity_engagement_external RLS: can see all users, but can only modify its own record
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_external_select_connectivity_engagement_user', 'connectivity_engagement_user', 'select', 'connectivity_engagement_external', 'true');
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_external_insert_connectivity_engagement_user', 'connectivity_engagement_user', 'insert', 'connectivity_engagement_external', 'uuid=(select sub from connectivity_engagement.session())');
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_external_update_connectivity_engagement_user', 'connectivity_engagement_user', 'update', 'connectivity_engagement_external', 'uuid=(select sub from connectivity_engagement.session())');


-- connectivity_engagement_guest RLS: can only see its own (empty) record
perform connectivity_engagement_private.upsert_policy('connectivity_engagement_guest_select_connectivity_engagement_user', 'connectivity_engagement_user', 'select', 'connectivity_engagement_guest', 'uuid=(select sub from connectivity_engagement.session())');

end
$policy$;

comment on table connectivity_engagement.connectivity_engagement_user is 'Table containing information about the application''s users ';
comment on column connectivity_engagement.connectivity_engagement_user.id is 'Unique ID for the user';
comment on column connectivity_engagement.connectivity_engagement_user.uuid is 'Universally Unique ID for the user, defined by the single sign-on provider';
comment on column connectivity_engagement.connectivity_engagement_user.first_name is 'User''s first name';
comment on column connectivity_engagement.connectivity_engagement_user.last_name is 'User''s last name';
comment on column connectivity_engagement.connectivity_engagement_user.email_address is 'User''s email address';

commit;

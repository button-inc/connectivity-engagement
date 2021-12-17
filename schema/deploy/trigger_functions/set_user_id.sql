-- Deploy connectivity_engagement:trigger_functions/set_user_id to pg
-- requires: functions/session
-- requires: table/connectivity_engagement_user

begin;
create or replace function connectivity_engagement_private.set_user_id()
  returns trigger as $$

declare
  user_sub uuid;
begin
  user_sub := (select sub from connectivity_engagement.session());
  new.user_id := (select id from connectivity_engagement.connectivity_engagement_user as u where u.uuid = user_sub);
  return new;
end;
$$ language plpgsql volatile;

grant execute on function connectivity_engagement_private.set_user_id to connectivity_engagement_internal,connectivity_engagement_external,connectivity_engagement_admin;

comment on function connectivity_engagement_private.set_user_id()
  is $$
  a trigger to set a user_id foreign key column.
  example usage:

  create table some_schema.some_table (
    user_id int references connectivity_engagement.connectivity_engagement_user(id)
    ...
  );
  create trigger _set_user_id
    before update of some_column on some_schema.some_table
    for each row
    execute procedure connectivity_engagement_private.set_user_id();
  $$;

commit;

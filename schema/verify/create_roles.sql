-- Verify connectivity_engagement:create_roles on pg

begin;

do
$verify$
begin


  if(select not exists(select true from pg_roles where rolname='connectivity_engagement_internal')) then
    raise exception 'role connectivity_engagement_internal does not exist.';

  elsif(select not exists(select true from pg_roles where rolname='connectivity_engagement_external')) then
    raise exception 'role connectivity_engagement_external does not exist.';

  elsif(select not exists(select true from pg_roles where rolname='connectivity_engagement_admin')) then
    raise exception 'role connectivity_engagement_admin does not exist.';

  elsif(select not exists(select true from pg_roles where rolname='connectivity_engagement_guest')) then
    raise exception 'role connectivity_engagement_guest does not exist.';

  end if;

end
$verify$;

rollback;

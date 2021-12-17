-- Deploy connectivity_engagement:create_roles to pg

begin;

-- The create roles affects the database globally. Cannot drop the roles once created.
do
$do$
begin
  
  if not exists (
    select true
    from   pg_catalog.pg_roles
    where  rolname = 'connectivity_engagement_internal') then

    create role connectivity_engagement_internal;
  end if;
  
  if not exists (
    select true
    from   pg_catalog.pg_roles
    where  rolname = 'connectivity_engagement_external') then

    create role connectivity_engagement_external;
  end if;
  
  if not exists (
    select true
    from   pg_catalog.pg_roles
    where  rolname = 'connectivity_engagement_admin') then

    create role connectivity_engagement_admin;
  end if;
  
  if not exists (
    select true
    from   pg_catalog.pg_roles
    where  rolname = 'connectivity_engagement_guest') then

    create role connectivity_engagement_guest;
  end if;
  

end
$do$;

commit;

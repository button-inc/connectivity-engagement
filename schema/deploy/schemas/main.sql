-- Deploy connectivity_engagement:schema/connectivity_engagement to pg

begin;

create schema connectivity_engagement;
grant usage on schema connectivity_engagement to connectivity_engagement_internal, connectivity_engagement_external, connectivity_engagement_admin, connectivity_engagement_guest;
comment on schema connectivity_engagement is 'The main schema for the connectivity_engagement application.';

commit;

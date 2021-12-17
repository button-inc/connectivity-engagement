-- Deploy connectivity_engagement:schema/connectivity_engagement_private to pg

begin;

create schema connectivity_engagement_private;
grant usage on schema connectivity_engagement_private to connectivity_engagement_internal, connectivity_engagement_external, connectivity_engagement_admin;
comment on schema connectivity_engagement_private is 'The private schema for the connectivity_engagement application. It contains utility functions which should not be available directly through the API.';

commit;

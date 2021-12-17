-- Deploy mocks:schemas/main to pg

begin;

create schema mocks;
grant usage on schema mocks to connectivity_engagement_internal, connectivity_engagement_external, connectivity_engagement_admin, connectivity_engagement_guest;

comment on schema mocks is 'A schema for mock functions that can be used for either tests or dev/test environments';

commit;

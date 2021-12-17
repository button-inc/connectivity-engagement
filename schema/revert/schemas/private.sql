-- Revert connectivity_engagement:schema/connectivity_engagement_private from pg

begin;

drop schema connectivity_engagement_private;

commit;

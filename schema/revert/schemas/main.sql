-- Revert connectivity_engagement:schema/connectivity_engagement from pg

begin;

drop schema connectivity_engagement;

commit;

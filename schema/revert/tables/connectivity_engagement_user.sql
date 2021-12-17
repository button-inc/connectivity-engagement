-- Revert connectivity_engagement:tables/connectivity_engagement_user on pg

begin;

drop table connectivity_engagement.connectivity_engagement_user;

commit;

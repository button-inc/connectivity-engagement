-- Revert connectivity_engagement:tables/connect_session on pg

begin;

drop table connectivity_engagement_private.connect_session;

commit;

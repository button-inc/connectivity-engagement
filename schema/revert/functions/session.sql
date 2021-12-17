-- Revert connectivity_engagement:functions/session from pg


begin;

drop function connectivity_engagement.session();

commit;

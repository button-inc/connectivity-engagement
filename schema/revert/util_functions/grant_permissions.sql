-- Revert connectivity_engagement:util_functions/grant_permissions from pg

begin;

drop function connectivity_engagement_private.grant_permissions(text, text, text, text);
drop function connectivity_engagement_private.grant_permissions(text, text, text, text[], text);

commit;

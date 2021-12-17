-- Revert connectivity_engagement:util_functions/verify_grant from pg

begin;

drop function connectivity_engagement_private.verify_grant(text, text, text, text);
drop function connectivity_engagement_private.verify_grant(text, text, text, text[], text);

commit;

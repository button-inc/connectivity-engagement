-- Revert connectivity_engagement:util_functions/verify_policy from pg

begin;

drop function connectivity_engagement_private.verify_policy(text, text, text, text, text);

commit;

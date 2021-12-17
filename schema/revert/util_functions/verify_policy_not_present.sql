-- Revert connectivity_engagement:util_functions/verify_policy_not_present from pg

begin;

drop function connectivity_engagement_private.verify_policy_not_present(text, text);

commit;

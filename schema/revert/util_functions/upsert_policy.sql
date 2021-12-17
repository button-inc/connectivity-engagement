-- Revert connectivity_engagement:util_functions/upsert_policy from pg

begin;

drop function connectivity_engagement_private.upsert_policy(text, text, text, text, text, text);
drop function connectivity_engagement_private.upsert_policy(text, text, text, text, text, text, text);

commit;

-- Revert connectivity_engagement:util_functions/read_only_user_policies from pg

begin;

drop function connectivity_engagement_private.read_only_user_policies(text, text);

commit;

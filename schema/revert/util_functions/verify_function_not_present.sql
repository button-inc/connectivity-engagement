-- Revert connectivity_engagement:util_functions/verify_function_not_present from pg

begin;

drop function connectivity_engagement_private.verify_function_not_present(text);

commit;

-- Revert connectivity_engagement:trigger_functions/set_user_id from pg

begin;

drop function connectivity_engagement_private.set_user_id;

commit;

-- Revert connectivity_engagement:trigger_functions/update_timestamps from pg

begin;

drop function connectivity_engagement_private.update_timestamps();

commit;

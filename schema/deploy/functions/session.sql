-- Deploy connectivity_engagement:function_session to pg
-- requires: schemas/main
-- requires: types/keycloak_jwt

begin;

create or replace function connectivity_engagement.session()
    returns connectivity_engagement.keycloak_jwt as
$function$
declare
  _sub text := current_setting('jwt.claims.sub', true);
begin
  if ((coalesce(trim(_sub), '') = '') is not false) then
    return null; -- ensure null, empty, and whitespace _sub claims are filtered out
  end if;
  return (
    select row (
      current_setting('jwt.claims.jti', true),
      current_setting('jwt.claims.exp', true),
      current_setting('jwt.claims.nbf', true),
      current_setting('jwt.claims.iat', true),
      current_setting('jwt.claims.iss', true),
      current_setting('jwt.claims.aud', true),
      _sub, -- subject can never be null
      current_setting('jwt.claims.typ', true),
      current_setting('jwt.claims.azp', true),
      current_setting('jwt.claims.auth_time', true),
      current_setting('jwt.claims.session_state', true),
      current_setting('jwt.claims.acr', true),
      current_setting('jwt.claims.email_verified', true),
      current_setting('jwt.claims.name', true),
      current_setting('jwt.claims.preferred_username', true),
      current_setting('jwt.claims.given_name', true),
      current_setting('jwt.claims.family_name', true),
      current_setting('jwt.claims.email', true),
      current_setting('jwt.claims.broker_session_id', true),
      current_setting('jwt.claims.priority_group', true),
      (select string_to_array(current_setting('jwt.claims.user_groups', true), ','))
    )::connectivity_engagement.keycloak_jwt
  );
end
$function$ language 'plpgsql' stable;

grant execute on function connectivity_engagement.session to connectivity_engagement_internal, connectivity_engagement_external, connectivity_engagement_admin, connectivity_engagement_guest;

commit;

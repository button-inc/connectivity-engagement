-- Revert connectivity_engagement:types/keycloak_jwt from pg

begin;

drop type connectivity_engagement.keycloak_jwt;

commit;

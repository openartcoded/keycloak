ARG KEYCLOAK_VERSION=21.0.2
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} as builder

ENV KC_METRICS_ENABLED=false
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} 

COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=root




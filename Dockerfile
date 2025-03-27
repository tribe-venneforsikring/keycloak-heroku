FROM quay.io/keycloak/keycloak:13.0.1

ENV KEYCLOAK_LOG_LEVEL=DEBUG
ENV KEYCLOAK_LOG_OUTPUT=default
ENV QUARKUS_LOG_CONSOLE_LEVEL=DEBUG
ENV QUARKUS_LOG_CATEGORY__ORG_KEYCLOAK_PROTOCOL_OIDC_LEVEL=DEBUG
ENV QUARKUS_LOG_CATEGORY__ORG_KEYCLOAK_BROKER_OIDC_LEVEL=DEBUG
ENV QUARKUS_LOG_CATEGORY__ORG_KEYCLOAK_AUTHENTICATION_LEVEL=DEBUG
ENV QUARKUS_LOG_CATEGORY__ORG_KEYCLOAK_EVENTS_LEVEL=DEBUG
ENV QUARKUS_LOG_CATEGORY__IO_QUARKUS_SECURITY_LEVEL=DEBUG
ENV QUARKUS_LOG_CATEGORY__ORG_KEYCLOAK_ADAPTER_OIDC_LEVEL=DEBUG

COPY docker-entrypoint.sh /opt/jboss/tools
COPY themes/wtc /opt/jboss/keycloak/themes/wtc
COPY deployments/keycloak-to-rabbit-1.12.jar /opt/jboss/keycloak/standalone/deployments/
COPY deployments/keycloak-signicat-1.7.jar /opt/jboss/keycloak/standalone/deployments/
COPY scripts/keycloak-to-rabbit.cli /opt/jboss/startup-scripts
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
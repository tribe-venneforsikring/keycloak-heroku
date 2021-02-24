FROM quay.io/keycloak/keycloak:12.0.1

COPY docker-entrypoint.sh /opt/jboss/tools
COPY themes/wtc /opt/jboss/keycloak/themes/wtc
COPY deployments/keycloak-to-rabbit-1.12.jar /opt/jboss/keycloak/standalone/deployments/
COPY deployments/keycloak-signicat-1.2.jar /opt/jboss/keycloak/standalone/deployments/
COPY deployments/keycloak-signicat-1.3.jar /opt/jboss/keycloak/standalone/deployments/
COPY scripts/keycloak-to-rabbit.cli /opt/jboss/startup-scripts
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
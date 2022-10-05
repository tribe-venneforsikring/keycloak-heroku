package com.gwidgets.resources;

import java.util.stream.Stream;
import java.util.Objects;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;

public class ApiKeyResource {

    private KeycloakSession session;

    private final String realmName;

    public ApiKeyResource(KeycloakSession session) {
        this.session = session;
        String envRealmName = System.getenv("REALM_NAME");
        this.realmName = Objects.isNull(envRealmName) || Objects.equals(System.getenv(envRealmName), "")? "example": envRealmName;
    }

    @GET
    @Produces("application/json")
    public Response checkApiKey(@HeaderParam("x-api-key") String apiKey) {
        Stream<UserModel> result = session.userStorageManager().searchForUserByUserAttributeStream(session.realms().getRealm(realmName), "api-key", "api-key"); 
        return result.count() == 0 ? Response.status(401).type(MediaType.APPLICATION_JSON).build(): Response.ok().type(MediaType.APPLICATION_JSON).build();
    }
}

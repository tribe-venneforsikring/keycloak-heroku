package com.gwidgets.resources;

import java.util.stream.Stream;
import java.util.Objects;
import static java.lang.System.out;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;

public class ApiKeyResource {

    private KeycloakSession session;

    public ApiKeyResource(KeycloakSession session) {
        this.session = session;
    }

    @GET
    @Produces("application/json")
    public Response checkApiKey(@HeaderParam("x-api-key") String apiKey) {
        Stream<UserModel> result = this.session.userStorageManager().searchForUserByUserAttributeStream(session.getContext().getRealm(), "api-key", apiKey);
        return result.count() == 0 ? Response.status(401).type(MediaType.APPLICATION_JSON).build(): Response.ok().type(MediaType.APPLICATION_JSON).build();
    }
}

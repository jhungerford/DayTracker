package dev.daytracker.api;

import dev.daytracker.model.Activity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("v1/activity")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ActivityResource {
	private static final Logger log = LoggerFactory.getLogger(ActivityResource.class);

	@POST
	public Response create(Activity activity) {
		log.debug("Create activity: {}", activity);

		return Response.noContent().build();
	}
}

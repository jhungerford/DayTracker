package dev.daytracker.api;

import dev.daytracker.dao.ActivityDao;
import dev.daytracker.model.Activity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.List;

@Path("v1/activity")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ActivityResource {
	private static final Logger log = LoggerFactory.getLogger(ActivityResource.class);

	@Inject
	private ActivityDao activityDao;

	@GET
	public List<Activity> all() throws IOException {
		return activityDao.findAll();
	}

	@POST
	public Response create(Activity activity) throws IOException {
		log.debug("Create activity: {}", activity);

		activity.setUserId(-1L);
		activityDao.save(activity);

		return Response.noContent().build();
	}
}

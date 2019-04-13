package dev.daytracker.api;

import com.google.common.collect.ImmutableList;
import dev.daytracker.dao.ActivityDao;
import dev.daytracker.model.Activity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

@Path("/v1/activities")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ActivityResource {
	private static final Logger log = LoggerFactory.getLogger(ActivityResource.class);

	private ActivityDao activityDao;

	public ActivityResource(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}

	@GET
	public ImmutableList<Activity> all() {
		return activityDao.findAll();
	}

	@POST
	public Activity create(Activity activity) {
		log.debug("Create activity: {}", activity);

		long id = activityDao.save(activity);

		return activity.copy()
				.withId(id)
				.build();
	}

	@PUT
	@Path("/{id}")
	public Activity update(@PathParam("id") long id, Activity activity) {
		Activity withId = activity.copy().withId(id).build();

		activityDao.update(withId);

		return withId;

	}
}

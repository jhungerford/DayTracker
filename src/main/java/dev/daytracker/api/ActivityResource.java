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

@Path("/v1/activities")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ActivityResource {
	private static final Logger log = LoggerFactory.getLogger(ActivityResource.class);

	public static final long FAKE_USER_ID = -1L;

	@Inject
	private ActivityDao activityDao;

	@GET
	public ActivitiesResponse all() throws IOException {
		return new ActivitiesResponse(activityDao.findAll());
	}

	@POST
	public Response create(ActivityRequest activityRequest) throws IOException {
		Activity activity = activityRequest.getActivity();
		log.debug("Create activity: {}", activity);

		activity.setUserId(FAKE_USER_ID);
		String id = activityDao.save(activity);

		activity.setId(id);

		return Response.status(Response.Status.CREATED).entity(new ActivityResponse(activity)).build();
	}

	@PUT
	@Path("/{id}")
	public Response update(@PathParam("id") String id, ActivityRequest activityRequest) throws IOException {
		Activity activity = activityRequest.getActivity();

		activity.setUserId(FAKE_USER_ID);
		activityDao.update(id, activity);

		return Response.noContent().build();
	}

	private static class ActivityResponse {
		public final Activity activity;

		private ActivityResponse(Activity activity) {
			this.activity = activity;
		}

		public Activity getActivity() {
			return activity;
		}
	}

	private static class ActivitiesResponse {
		public final List<Activity> activities;

		private ActivitiesResponse(List<Activity> activities) {
			this.activities = activities;
		}

		public List<Activity> getActivities() {
			return activities;
		}
	}

	private static class ActivityRequest {
		public Activity activity;

		public Activity getActivity() {
			return activity;
		}

		public void setActivity(Activity activity) {
			this.activity = activity;
		}
	}
}

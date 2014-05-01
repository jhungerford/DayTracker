package dev.daytracker.api;

import com.yammer.dropwizard.jersey.params.LongParam;
import dev.daytracker.dao.ActivityDao;
import dev.daytracker.model.Activity;
import dev.daytracker.model.Day;
import dev.daytracker.param.OptionalLongParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Path("v1/activity")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ActivityResource {
	private static final Logger log = LoggerFactory.getLogger(ActivityResource.class);

	@Inject
	private ActivityDao activityDao;
	public static final long DAY_MS = 24 * 60 * 60 * 1000;

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

	@GET
	@Path("days")
	public List<Day> allGroupedByDay(@QueryParam("tzms") LongParam timezoneMSParam) throws IOException {
		List<Activity> activities = all();

		long timezoneMS = timezoneMSParam == null ? 0 : timezoneMSParam.get();

		long dayMS = -1;
		Day day = new Day();

		List<Day> days = new ArrayList<>();
		for (Activity activity : activities) {
			long activityDay = getDay(activity.getTimestamp(), timezoneMS);

			if (activityDay != dayMS) {
				day = new Day(activityDay - timezoneMS, new ArrayList<String>());
				days.add(day);
				dayMS = activityDay;
			}

			day.getActivities().add(activity.getText());
		}

		return days;
	}

	private long getDay(long timestampMS, long timezoneOffsetMS) {
		// TODO: this timezone math is whack, but I'm tired and it's after 11 (when this bug happens)
		return (timestampMS / DAY_MS) * DAY_MS + timezoneOffsetMS;
	}
}

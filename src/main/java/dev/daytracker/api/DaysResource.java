package dev.daytracker.api;

import dev.daytracker.model.Day;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Arrays;
import java.util.List;

@Path("v1/days")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class DaysResource {

	@GET
	public List<Day> all() {
		return Arrays.asList(
				new Day(1398816000, Arrays.asList(
						"Started DayTracker (again)",
						"Rode 5 miles to work in the wind"
				)),
				new Day(1398729600, Arrays.asList(
						"Ran 3 miles in 34 minutes",
						"Climbed for 2 hours",
						"Sent an 11a on lead",
						"Rode 5 miles to work"
				)),
				new Day(1398470400, Arrays.asList(
						"Biked up to NCAR from home",
						"Plaed TESO all day"
				))
		);
	}
}

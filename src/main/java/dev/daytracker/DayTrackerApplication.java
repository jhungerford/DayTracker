package dev.daytracker;

import dev.daytracker.api.ActivityResource;
import dev.daytracker.config.DayTrackerConfiguration;
import dev.daytracker.dao.InMemoryActivityDao;
import io.dropwizard.Application;
import io.dropwizard.assets.AssetsBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

public class DayTrackerApplication extends Application<DayTrackerConfiguration> {

	public String getName() {
		return "DayTracker";
	}

	public void initialize(Bootstrap<DayTrackerConfiguration> bootstrap) {
//		bootstrap.addBundle(new AssetsBundle("/web", "/web", "", "web"));
//		bootstrap.addBundle(new AssetsBundle("/html", "", "index.html", "html"));
	}

	public void run(DayTrackerConfiguration configuration, Environment environment) throws Exception {
		environment.jersey().setUrlPattern("/api/*");
		environment.jersey().register(new ActivityResource(new InMemoryActivityDao()));
	}

	public static void main(String[] args) throws Exception {
		new DayTrackerApplication().run(args);
	}
}

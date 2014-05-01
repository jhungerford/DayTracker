package dev.daytracker;

import com.yammer.dropwizard.Service;
import com.yammer.dropwizard.assets.AssetsBundle;
import com.yammer.dropwizard.config.Bootstrap;
import com.yammer.dropwizard.config.Configuration;
import com.yammer.dropwizard.config.Environment;
import dev.daytracker.api.ActivityResource;
import dev.daytracker.api.DaysResource;

public class DayTrackerMain extends Service<Configuration> {

	public void initialize(Bootstrap<Configuration> bootstrap) {
		bootstrap.setName("DayTracker");

		bootstrap.addBundle(new AssetsBundle("/web/", "/web/"));
		bootstrap.addBundle(new AssetsBundle("/html", "/", "index.html"));
	}

	public void run(Configuration configuration, Environment environment) throws Exception {
		environment.addResource(DaysResource.class);
		environment.addResource(ActivityResource.class);
	}

	public static void main(String[] args) throws Exception {
		new DayTrackerMain().run(args);
	}
}

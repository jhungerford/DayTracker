package dev.daytracker;

import com.google.inject.Guice;
import com.google.inject.Injector;
import dev.daytracker.api.ActivityResource;
import dev.daytracker.config.DayTrackerConfiguration;
import dev.daytracker.es.ManagedElasticSearch;
import dev.daytracker.guice.ConfigurationModule;
import dev.daytracker.guice.DaoModule;
import dev.daytracker.guice.ElasticSearchModule;
import dev.daytracker.health.ElasticSearchHealth;
import io.dropwizard.Application;
import io.dropwizard.assets.AssetsBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

public class DayTrackerApplication extends Application<DayTrackerConfiguration> {

	public String getName() {
		return "DayTracker";
	}

	public void initialize(Bootstrap<DayTrackerConfiguration> bootstrap) {
		bootstrap.addBundle(new AssetsBundle("/web", "/web", "", "web"));
		bootstrap.addBundle(new AssetsBundle("/html", "", "index.html", "html"));
	}

	public void run(DayTrackerConfiguration configuration, Environment environment) throws Exception {
		Injector injector = Guice.createInjector(new ConfigurationModule(configuration), new ElasticSearchModule(), new DaoModule());

		environment.lifecycle().manage(injector.getInstance(ManagedElasticSearch.class));

		environment.healthChecks().register("ElasticSearch", injector.getInstance(ElasticSearchHealth.class));

		environment.jersey().setUrlPattern("/api/*");
		environment.jersey().register(injector.getInstance(ActivityResource.class));
	}

	public static void main(String[] args) throws Exception {
		new DayTrackerApplication().run(args);
	}
}

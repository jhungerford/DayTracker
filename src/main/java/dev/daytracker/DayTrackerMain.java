package dev.daytracker;

import com.google.common.base.Function;
import com.google.common.collect.Lists;
import com.google.inject.Binding;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.TypeLiteral;
import com.yammer.dropwizard.Service;
import com.yammer.dropwizard.assets.AssetsBundle;
import com.yammer.dropwizard.config.Bootstrap;
import com.yammer.dropwizard.config.Environment;
import com.yammer.metrics.core.HealthCheck;
import dev.daytracker.api.ActivityResource;
import dev.daytracker.api.DaysResource;
import dev.daytracker.config.DayTrackerConfiguration;
import dev.daytracker.es.ManagedElasticSearch;
import dev.daytracker.guice.ConfigurationModule;
import dev.daytracker.guice.DaoModule;
import dev.daytracker.guice.ElasticSearchModule;
import dev.daytracker.health.ElasticSearchHealth;

import javax.annotation.Nullable;
import java.util.ArrayList;
import java.util.List;

public class DayTrackerMain extends Service<DayTrackerConfiguration> {

	public void initialize(Bootstrap<DayTrackerConfiguration> bootstrap) {
		bootstrap.setName("DayTracker");

		bootstrap.addBundle(new AssetsBundle("/web/", "/web/"));
		bootstrap.addBundle(new AssetsBundle("/html", "/", "index.html"));
	}

	public void run(DayTrackerConfiguration configuration, Environment environment) throws Exception {
		Injector injector = Guice.createInjector(new ConfigurationModule(configuration), new ElasticSearchModule(), new DaoModule());

		environment.manage(injector.getInstance(ManagedElasticSearch.class));

		// TODO: does this work?
		for (HealthCheck healthCheck : allBeansOfType(injector, HealthCheck.class)) {
			environment.addHealthCheck(healthCheck);
		}

		environment.addHealthCheck(injector.getInstance(ElasticSearchHealth.class));

		// TODO: auto-register resources?
		environment.addResource(injector.getInstance(DaysResource.class));
		environment.addResource(injector.getInstance(ActivityResource.class));
	}

	private <T> List<T> allBeansOfType(final Injector injector, final Class<T> type) {
		return Lists.transform(injector.findBindingsByType(TypeLiteral.get(type)), new Function<Binding<T>, T>() {
			@Nullable
			public T apply(@Nullable Binding<T> binding) {
				return binding == null ? null : injector.getInstance(binding.getKey());
			}
		});
	}

	public static void main(String[] args) throws Exception {
		new DayTrackerMain().run(args);
	}
}

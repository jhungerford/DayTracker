package dev.daytracker.guice;

import com.google.inject.AbstractModule;
import dev.daytracker.config.DayTrackerConfiguration;

public class ConfigurationModule extends AbstractModule {
	private DayTrackerConfiguration configuration;

	public ConfigurationModule(DayTrackerConfiguration configuration) {
		this.configuration = configuration;
	}

	protected void configure() {
		bind(DayTrackerConfiguration.class).toInstance(configuration);
	}
}

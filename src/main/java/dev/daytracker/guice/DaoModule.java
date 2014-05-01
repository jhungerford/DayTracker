package dev.daytracker.guice;

import com.google.inject.AbstractModule;
import dev.daytracker.dao.ActivityDao;
import dev.daytracker.dao.ActivityDaoImpl;

public class DaoModule extends AbstractModule {
	protected void configure() {
		bind(ActivityDao.class).to(ActivityDaoImpl.class);
	}
}

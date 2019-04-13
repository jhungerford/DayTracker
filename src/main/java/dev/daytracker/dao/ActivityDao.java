package dev.daytracker.dao;

import com.google.common.collect.ImmutableList;
import dev.daytracker.model.Activity;

public interface ActivityDao {
	ImmutableList<Activity> findAll();
	long save(Activity activity);
	void update(Activity activity);
}

package dev.daytracker.dao;

import dev.daytracker.model.Activity;

import java.io.IOException;
import java.util.List;

public interface ActivityDao {

	List<Activity> findAll() throws IOException;
	void save(Activity activity) throws IOException;
	void update(String id, Activity activity) throws IOException;
}

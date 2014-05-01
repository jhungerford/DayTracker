package dev.daytracker.model;

import java.util.List;

public class Day {
	private long day;
	private List<String> activities;

	public Day() {}

	public Day(long day, List<String> activities) {
		this.day = day;
		this.activities = activities;
	}

	public long getDay() {
		return day;
	}

	public void setDay(long day) {
		this.day = day;
	}

	public List<String> getActivities() {
		return activities;
	}

	public void setActivities(List<String> activities) {
		this.activities = activities;
	}
}

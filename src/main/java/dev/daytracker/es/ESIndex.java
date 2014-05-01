package dev.daytracker.es;

public enum ESIndex {
	ACTIVITY("activity", "activity", "es/activity_index.json");

	public final String name;
	public final String type;
	public final String fileName;

	private ESIndex(String name, String type, String fileName) {
		this.name = name;
		this.type = type;
		this.fileName = fileName;
	}
}

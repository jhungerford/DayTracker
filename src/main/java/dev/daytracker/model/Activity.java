package dev.daytracker.model;

public class Activity {
	private long timestamp;
	private String text;

	public Activity() {}

	public Activity(long timestamp, String text) {
		this.timestamp = timestamp;
		this.text = text;
	}

	public long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String toString() {
		return "Activity{" +
				"timestamp=" + timestamp +
				", text='" + text + '\'' +
				'}';
	}
}

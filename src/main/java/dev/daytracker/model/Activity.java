package dev.daytracker.model;

public class Activity implements Identifyable {
	private String id;
	private Long userId;
	private long timestamp;
	private String text;

	public Activity() {}

	public Activity(String id, long userId, long timestamp, String text) {
		this.id = id;
		this.userId = userId;
		this.timestamp = timestamp;
		this.text = text;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
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
				"userId=" + userId +
				", timestamp=" + timestamp +
				", text='" + text + '\'' +
				'}';
	}
}

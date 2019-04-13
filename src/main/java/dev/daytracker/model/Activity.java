package dev.daytracker.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import java.time.Instant;

@JsonDeserialize(builder = Activity.Builder.class)
public class Activity {
	public final Long id;
	public final Instant timestamp;
	public final String text;

	private Activity(Builder builder) {
		this.id = builder.id;
		this.timestamp = builder.timestamp;
		this.text = builder.text;
	}

	public Builder copy() {
		return newBuilder()
				.withId(id)
				.withTimestamp(timestamp)
				.withText(text);
	}

	public static Builder newBuilder() {
		return new Builder();
	}

	public static class Builder {
		private Long id;
		private Instant timestamp;
		private String text;

		private Builder() {}

		public Builder withId(long id) {
			this.id = id;
			return this;
		}

		public Builder withTimestamp(Instant timestamp) {
			this.timestamp = timestamp;
			return this;
		}

		public Builder withText(String text) {
			this.text = text;
			return this;
		}

		public Activity build() {
			return new Activity(this);
		}
	}
}

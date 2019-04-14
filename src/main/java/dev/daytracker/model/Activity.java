package dev.daytracker.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import java.time.LocalDate;

@JsonDeserialize(builder = Activity.Builder.class)
public class Activity {
	public final Long id;
	public final LocalDate date;
	public final String text;

	private Activity(Builder builder) {
		this.id = builder.id;
		this.date = builder.date;
		this.text = builder.text;
	}

	public Builder copy() {
		return newBuilder()
				.withId(id)
				.withDate(date)
				.withText(text);
	}

	public static Builder newBuilder() {
		return new Builder();
	}

	public static class Builder {
		private Long id;
		private LocalDate date;
		private String text;

		private Builder() {}

		public Builder withId(long id) {
			this.id = id;
			return this;
		}

		public Builder withDate(LocalDate date) {
			this.date = date;
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

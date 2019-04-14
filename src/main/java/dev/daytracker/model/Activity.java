package dev.daytracker.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

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

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		Activity activity = (Activity) o;
		return Objects.equal(id, activity.id) &&
				Objects.equal(date, activity.date) &&
				Objects.equal(text, activity.text);
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(id, date, text);
	}

	@Override
	public String toString() {
		return MoreObjects.toStringHelper(this)
				.add("id", id)
				.add("date", date)
				.add("text", text)
				.toString();
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

		public Builder withId(Long id) {
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

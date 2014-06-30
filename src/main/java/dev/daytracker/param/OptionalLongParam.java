package dev.daytracker.param;

import io.dropwizard.jersey.params.LongParam;

public class OptionalLongParam extends LongParam {

	public OptionalLongParam(String input) {
		super(input);
	}

	protected Long parse(String input) {
		return input == null ? null : Long.parseLong(input);
	}

	public long getOrDefault(long defaultValue) {
		return get() == null ? defaultValue : get();
	}
}

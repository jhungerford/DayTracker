package dev.daytracker.dao;

import com.google.common.collect.ImmutableList;
import dev.daytracker.model.Activity;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class InMemoryActivityDao implements ActivityDao {

  private final AtomicLong nextId = new AtomicLong();
  private final List<Activity> activities = new CopyOnWriteArrayList<>();

  @Override
  public ImmutableList<Activity> findAll() {
    return ImmutableList.copyOf(activities);
  }

  @Override
  public long save(Activity activity) {
    activities.add(activity);
    return nextId.getAndIncrement();
  }

  @Override
  public void update(Activity activity) {
    throw new IllegalStateException("Not implemented"); // TODO: implement
  }
}

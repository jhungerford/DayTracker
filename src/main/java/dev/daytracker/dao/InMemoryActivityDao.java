package dev.daytracker.dao;

import com.google.common.collect.ImmutableList;
import dev.daytracker.model.Activity;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicLong;

public class InMemoryActivityDao implements ActivityDao {

  private final AtomicLong nextId = new AtomicLong();
  private final List<Activity> activities = new CopyOnWriteArrayList<>();

  @Override
  public ImmutableList<Activity> findAll() {
    return ImmutableList.copyOf(activities);
  }

  @Override
  public synchronized long save(Activity activity) {
    long id = nextId.getAndIncrement();

    Activity activityWithId = activity.copy()
        .withId(id)
        .build();

    activities.add(activityWithId);

    return id;
  }

  @Override
  public synchronized void update(Activity activity) {
    int index = indexOf(activity);
    if (index == -1) {
      return;
    }

    activities.set(index, activity);
  }

  private int indexOf(Activity activity) {
    for (int i = 0; i < activities.size(); i ++) {
      if (activities.get(i).id.equals(activity.id)) {
        return i;
      }
    }

    return -1;
  }

  public synchronized void reset() {
    nextId.set(0);
    activities.clear();
  }
}

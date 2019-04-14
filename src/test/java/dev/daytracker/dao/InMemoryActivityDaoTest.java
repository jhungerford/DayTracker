package dev.daytracker.dao;

import com.google.common.collect.ImmutableList;
import dev.daytracker.model.Activity;
import dev.daytracker.model.TestData;
import org.junit.After;
import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class InMemoryActivityDaoTest {

  private final InMemoryActivityDao dao = new InMemoryActivityDao();

  @After
  public void tearDown() {
    dao.reset();
  }

  @Test
  public void findAllEmpty() {
    assertThat(dao.findAll()).isEmpty();
  }

  @Test
  public void create() {
    Activity activity = TestData.randomActivity();

    long id = dao.save(activity);

    assertThat(dao.findAll()).containsExactly(
        activity.copy().withId(id).build()
    );
  }

  @Test
  public void createTwo() {
    Activity activity1 = TestData.randomActivity();
    Activity activity2 = TestData.randomActivity();

    long id1 = dao.save(activity1);
    long id2 = dao.save(activity2);

    assertThat(id1).isNotEqualTo(id2);

    assertThat(dao.findAll()).containsExactlyInAnyOrder(
        activity1.copy().withId(id1).build(),
        activity2.copy().withId(id2).build()
    );
  }

  @Test
  public void updateExists() {
    Activity activity = TestData.randomActivity();
    Activity updated = TestData.randomActivity();

    // Several other activities before
    for (int i = 0; i < 3; i ++) {
      dao.save(TestData.randomActivity());
    }

    long id = dao.save(activity);

    // Several after
    for (int i = 0; i < 3; i ++) {
      dao.save(TestData.randomActivity());
    }

    // Make sure the activity exists.
    assertThat(dao.findAll()).contains(
        activity.copy().withId(id).build()
    );

    // Update it, make sure the updated activity exists and the old one doesn't.
    dao.update(updated.copy().withId(id).build());

    assertThat(dao.findAll()).extracting(a -> a.id).containsOnlyOnce(id); // Replaced - only one with the id.

    assertThat(dao.findAll()).doesNotContain(activity.copy().withId(id).build());
    assertThat(dao.findAll()).contains(updated.copy().withId(id).build());
  }

  @Test
  public void updateNotFound() {
    Activity activity = TestData.randomActivity();
    Activity updated = TestData.randomActivity();

    // Several other activities before
    for (int i = 0; i < 3; i ++) {
      dao.save(TestData.randomActivity());
    }

    long id = dao.save(activity);

    // Several after
    for (int i = 0; i < 3; i ++) {
      dao.save(TestData.randomActivity());
    }

    // Make sure the activity exists.
    ImmutableList<Activity> beforeUpdate = dao.findAll();

    // Try to update the activity with a fake id - nothing should change.
    dao.update(updated.copy().withId(-1000L).build());

    assertThat(dao.findAll()).isEqualTo(beforeUpdate);
  }
}
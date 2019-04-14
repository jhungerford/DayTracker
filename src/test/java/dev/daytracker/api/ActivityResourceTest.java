package dev.daytracker.api;

import com.google.common.collect.ImmutableList;
import dev.daytracker.dao.InMemoryActivityDao;
import dev.daytracker.model.Activity;
import io.dropwizard.testing.junit.ResourceTestRule;
import org.junit.After;
import org.junit.ClassRule;
import org.junit.Test;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.GenericType;
import java.time.LocalDate;

import static dev.daytracker.DayTrackerApplication.configureJson;
import static org.assertj.core.api.Assertions.assertThat;

public class ActivityResourceTest {

  private static final GenericType<ImmutableList<Activity>> ACTIVITY_LIST_TYPE =
      new GenericType<ImmutableList<Activity>>() {};

  private static final InMemoryActivityDao activityDao = new InMemoryActivityDao();

  @ClassRule
  public static final ResourceTestRule resources = ResourceTestRule.builder()
      .addResource(new ActivityResource(activityDao))
      .build();

  static {
    configureJson(resources.getObjectMapper());
  }

  @After
  public void tearDown() {
    activityDao.reset();
  }

  @Test
  public void findAllEmpty() {
    assertThat(resources.target("/v1/activities").request().get(ACTIVITY_LIST_TYPE)).isEmpty();
  }

  @Test
  public void createOneActivity() {
    Activity activity = Activity.newBuilder()
        .withDate(LocalDate.now())
        .withText("New activity")
        .build();

    Activity created = resources.target("/v1/activities").request().post(Entity.json(activity), Activity.class);

    assertThat(created.id).isNotNull();
    assertThat(created).isEqualToIgnoringGivenFields(activity, "id");

    assertThat(activityDao.findAll()).containsExactly(created);
  }
}
package dev.daytracker;

import dev.daytracker.config.DayTrackerConfiguration;
import io.dropwizard.testing.junit.DropwizardAppRule;
import org.eclipse.jetty.http.HttpStatus;
import org.junit.ClassRule;
import org.junit.Test;

import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Integration test that runs the day tracker application and checks that endpoints are accessible.
 */
public class DayTrackerApplicationTest {

  @ClassRule
  public static DropwizardAppRule<DayTrackerConfiguration> APP_RULE = new DropwizardAppRule<>(DayTrackerApplication.class);

  @Test
  public void getIndex() {
    Response response = clientTarget().path("/").request().get();

    assertThat(response.getStatus()).isEqualTo(HttpStatus.OK_200);

    String index = response.readEntity(String.class);
    assertThat(index).startsWith("<!DOCTYPE html>");
  }

  @Test
  public void getActivitiesAPI() {
    Response response = clientTarget().path("/api/v1/activities").request().get();

    assertThat(response.getStatus()).isEqualTo(HttpStatus.OK_200);
    assertThat(response.getHeaders().getFirst("Content-Type")).isEqualTo("application/json");
  }

  private WebTarget clientTarget() {
    return APP_RULE.client().target(String.format("http://localhost:%d", APP_RULE.getLocalPort()));
  }
}
package dev.daytracker.health;


import com.codahale.metrics.health.HealthCheck;
import dev.daytracker.es.ElasticSearchAdmin;
import org.elasticsearch.ElasticsearchException;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthStatus;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import static org.fest.assertions.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ElasticSearchHealthTest {

	@Mock
	private ElasticSearchAdmin esAdmin;
	@InjectMocks
	private ElasticSearchHealth esHealth;

	@Test
	public void greenStatus() throws Exception {
		when(esAdmin.clusterHealthStatus()).thenReturn(ClusterHealthStatus.GREEN);

		HealthCheck.Result result = esHealth.check();
		assertThat(result).isNotNull();
		assertThat(result.isHealthy()).isTrue();
	}

	@Test
	public void yellowStatus() throws Exception {
		when(esAdmin.clusterHealthStatus()).thenReturn(ClusterHealthStatus.YELLOW);

		HealthCheck.Result result = esHealth.check();
		assertThat(result).isNotNull();
		assertThat(result.isHealthy()).isTrue();
	}

	@Test
	public void redStatus() throws Exception {
		when(esAdmin.clusterHealthStatus()).thenReturn(ClusterHealthStatus.RED);

		HealthCheck.Result result = esHealth.check();
		assertThat(result).isNotNull();
		assertThat(result.isHealthy()).isFalse();
	}

	@Test
	public void exceptionFromHealthCheck() throws Exception {
		when(esAdmin.clusterHealthStatus()).thenThrow(new ElasticsearchException("Can't check health"));

		HealthCheck.Result result = esHealth.check();
		assertThat(result).isNotNull();
		assertThat(result.isHealthy()).isFalse();
	}
}

package dev.daytracker.health;

import com.yammer.metrics.core.HealthCheck;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthStatus;
import org.elasticsearch.action.admin.cluster.stats.ClusterStatsResponse;
import org.elasticsearch.client.Client;

import javax.inject.Inject;

public class ElasticSearchHealth extends HealthCheck {

	@Inject
	private Client client;

	public ElasticSearchHealth() {
		super("ElasticSearch");
	}

	protected Result check() throws Exception {
		ClusterStatsResponse clusterStatsResponse = client.admin().cluster().prepareClusterStats().execute().actionGet();

		if (clusterStatsResponse.getStatus() == ClusterHealthStatus.RED) {
			return Result.unhealthy("ES cluster is red");
		}

		return Result.healthy();
	}
}

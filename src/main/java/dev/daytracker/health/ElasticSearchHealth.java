package dev.daytracker.health;

import com.yammer.metrics.core.HealthCheck;
import dev.daytracker.es.ElasticSearchAdmin;
import org.elasticsearch.ElasticsearchException;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;

public class ElasticSearchHealth extends HealthCheck {
	private static final Logger log = LoggerFactory.getLogger(ElasticSearchHealth.class);

	@Inject
	private ElasticSearchAdmin esAdmin;

	public ElasticSearchHealth() {
		super("ElasticSearch");
	}

	protected Result check() throws Exception {
		try {
			ClusterHealthStatus clusterHealth = esAdmin.clusterHealthStatus();

			if (clusterHealth == ClusterHealthStatus.RED) {
				return Result.unhealthy("ES cluster is red");
			}
		} catch (ElasticsearchException e) {
			log.error("Cluster health check failed", e);
			return Result.unhealthy("Cluster health threw an exception (%s)- ES is very unhappy", e.getMessage());
		}

		return Result.healthy();
	}
}

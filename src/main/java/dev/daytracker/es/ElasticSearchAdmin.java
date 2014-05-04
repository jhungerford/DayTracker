package dev.daytracker.es;

import org.elasticsearch.action.admin.cluster.health.ClusterHealthStatus;

import java.io.IOException;

public interface ElasticSearchAdmin {
	void createIndex(ESIndex index) throws IOException;

	boolean indexExists(String name);

	ClusterHealthStatus clusterHealthStatus();
}

package dev.daytracker.es;

import com.google.common.io.Resources;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthStatus;
import org.elasticsearch.action.admin.cluster.stats.ClusterStatsResponse;
import org.elasticsearch.client.Client;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import java.io.IOException;
import java.nio.charset.Charset;

public class ElasticSearchAdminImpl implements ElasticSearchAdmin {
	private static final Logger log = LoggerFactory.getLogger(ElasticSearchAdminImpl.class);

	@Inject
	private Client client;

	@Override
	public void createIndex(ESIndex index) throws IOException {
		if (! indexExists(index.name)) {
			log.info("Creating ES index '{}' from {}", index.name, index.fileName);

			String source = Resources.toString(Resources.getResource(index.fileName), Charset.defaultCharset());
			client.admin().indices().prepareCreate(index.name).setSource(source).execute().actionGet();
			log.info("ES index {} created", index.name);
		} else {
			log.debug("Index {} already exists", index.name);
		}
	}

	@Override
	public boolean indexExists(String name) {
		return client.admin().indices().prepareExists(name).execute().actionGet().isExists();
	}

	@Override
	public ClusterHealthStatus clusterHealthStatus() {
		ClusterStatsResponse clusterStatsResponse = client.admin().cluster().prepareClusterStats().execute().actionGet();
		return clusterStatsResponse.getStatus();
	}
}

package dev.daytracker.es;

import io.dropwizard.lifecycle.Managed;
import org.elasticsearch.node.Node;

import javax.inject.Inject;

public class ManagedElasticSearch implements Managed {

	@Inject
	private Node node;

	@Inject
	private ElasticSearchAdmin esAdmin;

	public void start() throws Exception {
		node.start();

		for (ESIndex index : ESIndex.values()) {
			// TODO: check if the index exists and migrate / warn if the mapping changed.
			esAdmin.createIndex(index);
		}
	}

	public void stop() throws Exception {
		node.stop();
	}
}

package dev.daytracker.guice;

import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import com.google.inject.Singleton;
import dev.daytracker.es.ElasticSearchAdmin;
import dev.daytracker.es.ElasticSearchAdminImpl;
import org.elasticsearch.client.Client;
import org.elasticsearch.node.Node;
import org.elasticsearch.node.NodeBuilder;

public class ElasticSearchModule extends AbstractModule {
	protected void configure() {
		bind(ElasticSearchAdmin.class).to(ElasticSearchAdminImpl.class);
	}

	@Provides
	@Singleton
	private Node createNode() {
		// Create a local? node that persists data to data/ between restarts
		return NodeBuilder.nodeBuilder()
				.clusterName("day-tracker")
				.local(true)
				.data(true)
				.loadConfigSettings(false)
				.build();
	}

	@Provides
	private Client createClient(Node node) {
		return node.client();
	}
}

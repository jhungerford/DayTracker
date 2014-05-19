package dev.daytracker.dao;

import com.fasterxml.jackson.databind.ObjectMapper;
import dev.daytracker.es.ESIndex;
import dev.daytracker.model.Activity;
import dev.daytracker.model.Identifyable;
import org.elasticsearch.action.index.IndexRequestBuilder;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.sort.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ActivityDaoImpl implements ActivityDao {
	private static final Logger log = LoggerFactory.getLogger(ActivityDaoImpl.class);

	@Inject
	private ObjectMapper objectMapper;

	@Inject
	private Client client;

	public List<Activity> findAll() throws IOException {
		SearchRequestBuilder search = client.prepareSearch(ESIndex.ACTIVITY.name).addSort("timestamp", SortOrder.DESC);
		SearchResponse response = search.execute().actionGet();

		// TODO: handle errors
		return parseHits(response.getHits(), Activity.class);
	}

	public void save(Activity activity) throws IOException {
		String source = objectMapper.writeValueAsString(activity);

		IndexRequestBuilder request = client.prepareIndex(ESIndex.ACTIVITY.name, ESIndex.ACTIVITY.type)
				.setTimestamp(Long.toString(activity.getTimestamp()))
				.setSource(source);

		// TODO: handle the index response
		request.execute().actionGet();
	}

	private <T extends Identifyable> List<T> parseHits(SearchHits hits, Class<T> type) throws IOException {
		List<T> values = new ArrayList<>();

		for (SearchHit hit : hits) {
			T value = objectMapper.readValue(hit.getSourceAsString(), type);
			value.setId(hit.getId());
			values.add(value);
		}

		return values;
	}
}

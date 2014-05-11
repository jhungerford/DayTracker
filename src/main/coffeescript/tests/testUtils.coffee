define ['ember'], (Ember) ->
	TestUtils = {
		createView: (template, context) ->
			context = {} unless context

			View = Ember.View.extend
				controller: context,
				template: Ember.Handlebars.compile(template)

			View.create()

		appendView: (view) ->
			Ember.run ->
				view.appendTo('#qunit-view')

		stubAjax: (url, method, json) ->
			Ember.$.mockjax
				url: url
#				dataType: 'json'
				responseText: json

		now: -> new Date().getTime()

		daysBack: (numDays) -> @now() - numDays * 24 * 60 * 60 * 1000
	}

	TestUtils

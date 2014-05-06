define ['ember', 'mockJax'], (Ember) ->
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
				dataType: 'json'
				url: url
				responseText: json
	}

	TestUtils

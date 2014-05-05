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
	}

	TestUtils

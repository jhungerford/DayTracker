require.config
	deps: ['app', 'routes', 'handlebarHelpers', 'tests/tests']

	baseUrl: 'web/js'

	paths:
		ember: 'libs/ember/ember'
		emberData: 'libs/ember/ember-data'
		handlebars: 'libs/handlebars/handlebars'
		jQuery: 'libs/jquery/jquery'
		text: 'libs/require/text'
		qUnit: 'libs/qunit/qunit'

	shim:
		jQuery:
			exports: 'jQuery'
			init: () ->
				@.jQuery.noConflict()

		ember:
			deps: ['jQuery', 'handlebars']
			exports: 'Ember'

		emberData:
			deps: ['ember']
			exports: 'DS'

		handlebars:
			exports: 'Handlebars'

		qUnit:
			exports: 'QUnit'
			init: ->
				QUnit.config.autoload = false
				QUnit.config.autostart = false

# TODO: figure out how to eliminate code duplicated between testConfig and config
require.config
	deps: ['mockJax', 'app', 'routes', 'utils/handlebarHelpers', 'tests/tests']

	baseUrl: 'web/js'

	paths:
		ember: 'libs/ember/ember'
		emberData: 'libs/ember/ember-data'
		handlebars: 'libs/handlebars/handlebars'
		jQuery: 'libs/jquery/jquery'
		mockJax: 'libs/jquery/jquery.mockjax'
		text: 'libs/require/text'
		qUnit: 'libs/qunit/qunit'

	shim:
		jQuery:
			exports: 'jQuery'
			init: () ->
				@.jQuery.noConflict()

		mockJax:
			deps: ['jQuery']

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

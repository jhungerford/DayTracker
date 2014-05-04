require.config
	deps: ['tests/tests']

	baseUrl: 'web/js'

	paths:
		qUnit: 'libs/qunit/qunit'

	shim:
		'qUnit':
			exports: 'QUnit'
			init: ->
				QUnit.config.autoload = false
				QUnit.config.autostart = false

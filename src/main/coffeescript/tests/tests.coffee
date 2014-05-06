require ['app', 'ember', 'qUnit',
# Unit Tests
	'tests/unit/handlebarHelpers',
# Integration Tests
	'tests/integration/showActivity'
], (App, Ember, QUnit, tests...) ->
	App.rootElement = '#qunit-fixture' # Hidden property - override css to make it visible.

	Ember.$.mockjaxSettings.logging = true
	Ember.$.mockjaxSettings.responseTime = 0

	App.setupForTesting()
	App.injectTestHelpers()

	for test in tests
		if test?.run?
			test.run()
		else
			throw new Error('Test must be an object with a run method.')

	QUnit.load()
	QUnit.start()

# ADD NEW TESTS TO THE REQUIRE ARRAY - IT WILL BE AUTOMATICALLY RUN
require ['app', 'ember', 'qUnit',
# Unit Tests
	'tests/unit/mixins/comparable'
	'tests/unit/utils/dates'
	'tests/unit/utils/handlebarHelpers'
	'tests/unit/utils/functions'
# Integration Tests
	'tests/integration/showActivity'
], (App, Ember, QUnit, tests...) ->
	App.rootElement = '#qunit-fixture' # Hidden property - override css to make it visible.

	Ember.$.mockjaxSettings.logging = true
	Ember.$.mockjaxSettings.throwUnmocked = true
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

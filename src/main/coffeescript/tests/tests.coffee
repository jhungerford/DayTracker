require ['app', 'qUnit', 'tests/unit/sampleTest', 'tests/unit/handlebarHelpers'], (App, QUnit, sampleTest, handlebarHelpers) ->
	App.rootElement = '#qunit-fixture'
	App.setupForTesting()
	App.injectTestHelpers()

	sampleTest.run()
	handlebarHelpers.run()

	QUnit.load()
	QUnit.start()

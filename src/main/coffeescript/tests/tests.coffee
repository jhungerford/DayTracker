require ['app', 'qUnit', 'tests/unit/handlebarHelpers'], (App, QUnit, handlebarHelpers) ->
	App.rootElement = '#qunit-fixture'
	App.setupForTesting()
	App.injectTestHelpers()

	handlebarHelpers.run()

	QUnit.load()
	QUnit.start()

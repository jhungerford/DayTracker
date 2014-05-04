require ['app', 'qUnit', 'tests/unit/sampleTest'], (App, QUnit, sampleTest) ->
	App.rootElement = '#qunit-fixture'
	App.setupForTesting()
	App.injectTestHelpers()

	sampleTest.run()

	QUnit.load()
	QUnit.start()

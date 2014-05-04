require ['qUnit', 'tests/unit/sampleTest'], (QUnit, sampleTest) ->
	sampleTest.run()

	QUnit.load()
	QUnit.start()

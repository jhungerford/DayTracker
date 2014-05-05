define ['ember', 'tests/testUtils'], (Ember, TestUtils) ->

	testLogDate = (time, expected) ->
		view = TestUtils.createView("{{logDate " + time + "}}")
		TestUtils.appendView view

		equal view.$().text(), expected

	now = new Date().getTime()
	dayMS = 24 * 60 * 60 * 1000

	days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

	run = ->
		module 'Unit: handlebarHelpers: logDate',
			teardown: -> Ember.$('#qunit-view').empty()

		test 'now', ->
			testLogDate now, 'Today'

		test 'yesterday', ->
			testLogDate now - dayMS, 'Yesterday'

		test 'two days ago', ->
			testLogDate now - 2 * dayMS, 'Two days ago'

		test 'three days ago', ->
			date = now - 3 * dayMS
			testLogDate date, 'Last ' + days[new Date(date).getDay()]

		test 'January 2, 1970', ->
			testLogDate new Date(1970, 0, 2, 12, 0).getTime(), 'On 1/2/1970'

	{run: run}

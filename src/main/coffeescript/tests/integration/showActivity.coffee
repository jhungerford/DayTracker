define ['app', 'tests/testUtils'], (App, TestUtils) ->
	run = ->
		module 'Integration: showActivity',
			teardown: -> App.reset()

		test 'hello', -> ok true, 'true is tautological'

		test 'visit /, list all activity', ->
			expect 1

			TestUtils.stubAjax '/api/v1/activity/days', 'GET', '[{"day":1399096800000,"activities":["Tested DayTracker"]}]'

			visit '/'

			andThen ->
				equal find('li:last').text(), 'Tested DayTracker'


	{run: run}

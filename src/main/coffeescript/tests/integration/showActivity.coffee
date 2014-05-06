define ['app', 'tests/testUtils'], (App, TestUtils) ->
	run = ->
		module 'Integration: showActivity',
			teardown: -> App.reset()

		test 'visit /, list all activity', ->
			expect 2

			activity = [{
				day: new Date().getTime()
				activities: ['Tested DayTracker']
			}]

			TestUtils.stubAjax '/api/v1/activity/days', 'GET', JSON.stringify(activity)

			visit '/'

			andThen ->
				equal find('h4').text(), 'Today, I'
				equal find('li:last').text(), 'Tested DayTracker'


	{run: run}

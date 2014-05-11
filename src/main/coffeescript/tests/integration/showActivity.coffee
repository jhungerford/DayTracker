define ['ember', 'app', 'tests/testUtils'], (Ember, App, TestUtils) ->
	run = ->
		module 'Integration: showActivity',
			teardown: ->
				App.reset()
				Ember.$.mockjaxClear()

		test 'visit /, one day of activity', ->
			expect 2

			activity = [{
				day: TestUtils.now()
				activities: ['Tested DayTracker']
			}]

			TestUtils.stubAjax '/api/v1/activity/days', 'GET', JSON.stringify(activity)

			visit('/').then ->
				equal find('h4').text(), 'Today, I'
				equal find('li:last').text(), 'Tested DayTracker'

		test 'visit /, two days of activity', ->
			expect 4

			activity = [{
				day: TestUtils.now()
				activities: ['Did something today']
			},{
				day: TestUtils.daysBack(1)
				activities: ['Did something yesterday']
			}]

			TestUtils.stubAjax '/api/v1/activity/days', 'GET', JSON.stringify(activity)

			visit('/').then ->
				equal find('.activityTitle:eq(0)').text(), 'Today, I'
				equal find('.activity:eq(0)').text(), 'Did something today'
				equal find('.activityTitle:eq(1)').text(), 'Yesterday, I'
				equal find('.activity:eq(1)').text(), 'Did something yesterday'

	{run: run}

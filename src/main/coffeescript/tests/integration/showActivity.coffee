define ['ember', 'app', 'tests/testUtils'], (Ember, App, TestUtils) ->
	run: ->
		module 'Integration: showActivity',
			teardown: ->
				App.reset()
				Ember.$.mockjaxClear()

		test 'visit /, one day of activity', ->
			expect 2

			activity = {
				activity: [{
					id: 1
					timestamp: TestUtils.now()
					text: 'Tested DayTracker'
				}]
			}

			TestUtils.stubAjax '/api/v1/activities', 'GET', JSON.stringify(activity)

			visit('/activity').then ->
				equal find('h4').text(), 'Today, I'
				equal find('li:last').text(), 'Tested DayTracker'

		test 'visit /, two days of activity', ->
			expect 4

			activity = {
				activity: [{
					id: 1
					timestamp: TestUtils.now()
					text: 'Did something today'
				},{
					id: 2
					timestamp: TestUtils.daysBack(1)
					text: 'Did something yesterday'
				}]
			}

			TestUtils.stubAjax '/api/v1/activities', 'GET', JSON.stringify(activity)

			visit('/').then ->
				equal find('.activityTitle:eq(0)').text(), 'Today, I'
				equal find('.activity:eq(0)').text(), 'Did something today'
				equal find('.activityTitle:eq(1)').text(), 'Yesterday, I'
				equal find('.activity:eq(1)').text(), 'Did something yesterday'

define ['ember', 'utils/dates', 'utils/handlebarHelpers'], (Ember, Dates, Helpers) ->

	today = Dates.today()

	testLogDate = (time, expected) ->
		equal Helpers.formatDate(today, time), expected

	run: ->
		mdt = 21600000 # GMT-6
		oldTimezone = Dates.get('localTimezoneMS')

		module 'Unit: formatDate',
			setup: ->
				Dates.set('localTimezoneMS', mdt)
			teardown: ->
				Dates.set('localTimezoneMS', oldTimezone)
				Ember.$('#qunit-view').empty()

		test 'tomorrow', ->
			testLogDate Dates.now().plus(1, 'days'), 'In the future'

		test 'today', ->
			testLogDate Dates.today(), 'Today'

		test 'yesterday', ->
			testLogDate Dates.today().minus(1, 'days'), 'Yesterday'

		test 'two days ago', ->
			testLogDate Dates.today().minus(2, 'days'), 'Two days ago'

		test 'three days ago', ->
			date = Dates.today().minus(3, 'days')
			testLogDate date, 'Last ' + Dates.days[date.get('asDate').getUTCDay()]

		test 'January 2, 1970', ->
			day = Dates.morning(new Date(1970, 0, 2, 12, 0).getTime())
			testLogDate day, 'On 1/2/1970'

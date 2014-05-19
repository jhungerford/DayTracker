define ['ember', 'utils/dates'], (Ember, Dates) ->
	run: ->
		mdt = 21600000 # GMT-6
		oldTimezone = Dates.get('localTimezoneMS')

		module 'Unit: utils/dates'
			setup: -> Dates.set('localTimezoneMS', mdt)
			teardown: -> Dates.set('localTimezoneMS', oldTimezone)

		test 'now is the current time', ->
			now = Dates.now()
			ok Math.abs(now.get('asMS') - new Date().getTime()) < 10 # If this takes more than 10ms, upgrade your browser.

		test 'today is this morning with the local date UTC 00:00 time', ->
			expect 7

			today = Dates.today()
			todayDate = today.get('asDate')
			now = new Date()

			equal today.get('year'), now.getFullYear(), 'year'
			equal today.get('month'), now.getMonth() + 1, 'month'
			equal today.get('date'), now.getDate(), 'date'

			equal todayDate.getUTCHours(), 0, 'hours'
			equal todayDate.getUTCMinutes(), 0, 'minutes'
			equal todayDate.getUTCSeconds(), 0, 'seconds'
			equal todayDate.getUTCMilliseconds(), 0, 'milliseconds'

		test 'morning - January 21', ->
			expect 8

			day = Dates.morning(1390369725219) # GMT-6: 1/21/2014 22:48:45 PM
			dayDate = day.get('asDate')

			equal day.get('humanDay'), 'Tuesday'

			equal day.get('year'), 2014, 'year'
			equal day.get('month'), 1, 'month'
			equal day.get('date'), 21, 'date'

			equal dayDate.getUTCHours(), 0, 'hours'
			equal dayDate.getUTCMinutes(), 0, 'minutes'
			equal dayDate.getUTCSeconds(), 0, 'seconds'
			equal dayDate.getUTCMilliseconds(), 0, 'milliseconds'

		test 'today + 2 days', ->
			today = Dates.today()
			dayAfterTomorrow = today.plus(2, 'days')

			equal dayAfterTomorrow.get('asMS'), today.get('asMS') + 2*24*60*60*1000

		test 'today - 2 days', ->
			today = Dates.today()
			dayBeforeYesterday = today.minus(2, 'days')

			equal dayBeforeYesterday.get('asMS'), today.get('asMS') - 2*24*60*60*1000

		test 'compare today to yesterday', ->
			today = Dates.today()
			yesterday = today.minus(1, 'days')

			equal today.compare(yesterday), 1
			equal yesterday.compare(today), -1
			equal today.compare(today), 0

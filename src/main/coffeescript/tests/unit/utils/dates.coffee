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

		test 'plusMonths', ->
			expect 12

			janFirst2004 = Dates.morning(1072940401000)

			equal janFirst2004.get('month'), 1
			equal janFirst2004.plus(1, 'months').get('month'), 2
			equal janFirst2004.plus(2, 'months').get('month'), 3
			equal janFirst2004.plus(3, 'months').get('month'), 4
			equal janFirst2004.plus(4, 'months').get('month'), 5
			equal janFirst2004.plus(5, 'months').get('month'), 6
			equal janFirst2004.plus(6, 'months').get('month'), 7
			equal janFirst2004.plus(7, 'months').get('month'), 8
			equal janFirst2004.plus(8, 'months').get('month'), 9
			equal janFirst2004.plus(9, 'months').get('month'), 10
			equal janFirst2004.plus(10, 'months').get('month'), 11
			equal janFirst2004.plus(11, 'months').get('month'), 12

		test 'leapYear: 2004', ->
			equal Dates.leapYear(2004), true

		test 'leapYear: 2005', ->
			equal Dates.leapYear(2005), false

		test 'leapYear: 1900', ->
			equal Dates.leapYear(1900), false

		test 'leapYear: 2000', ->
			equal Dates.leapYear(2000), true

		test 'daysInMonth: February leap year', ->
			expect 12

			janFirst2004 = Dates.morning(1072940401000)

			equal Dates.daysInMonth(janFirst2004), 31
			equal Dates.daysInMonth(janFirst2004.plus(1, 'months')), 29
			equal Dates.daysInMonth(janFirst2004.plus(2, 'months')), 31
			equal Dates.daysInMonth(janFirst2004.plus(3, 'months')), 30
			equal Dates.daysInMonth(janFirst2004.plus(4, 'months')), 31
			equal Dates.daysInMonth(janFirst2004.plus(5, 'months')), 30
			equal Dates.daysInMonth(janFirst2004.plus(6, 'months')), 31
			equal Dates.daysInMonth(janFirst2004.plus(7, 'months')), 31
			equal Dates.daysInMonth(janFirst2004.plus(8, 'months')), 30
			equal Dates.daysInMonth(janFirst2004.plus(9, 'months')), 31
			equal Dates.daysInMonth(janFirst2004.plus(10, 'months')), 30
			equal Dates.daysInMonth(janFirst2004.plus(11, 'months')), 31

		test 'daysInMonth: not leap year', ->
			expect 12

			janFirst2005 = Dates.morning(1104562801000)

			equal Dates.daysInMonth(janFirst2005), 31
			equal Dates.daysInMonth(janFirst2005.plus(1, 'months')), 28
			equal Dates.daysInMonth(janFirst2005.plus(2, 'months')), 31
			equal Dates.daysInMonth(janFirst2005.plus(3, 'months')), 30
			equal Dates.daysInMonth(janFirst2005.plus(4, 'months')), 31
			equal Dates.daysInMonth(janFirst2005.plus(5, 'months')), 30
			equal Dates.daysInMonth(janFirst2005.plus(6, 'months')), 31
			equal Dates.daysInMonth(janFirst2005.plus(7, 'months')), 31
			equal Dates.daysInMonth(janFirst2005.plus(8, 'months')), 30
			equal Dates.daysInMonth(janFirst2005.plus(9, 'months')), 31
			equal Dates.daysInMonth(janFirst2005.plus(10, 'months')), 30
			equal Dates.daysInMonth(janFirst2005.plus(11, 'months')), 31

		test 'startOfMonth jan 1, 2005', ->
			janFirst2005 = Dates.morning(1104562801000)
			equal Dates.startOfMonth(janFirst2005), 6

		test 'startOfMonth July 25, 2014', ->
			date = Dates.morning(1406308887000)
			equal Dates.startOfMonth(date), 2

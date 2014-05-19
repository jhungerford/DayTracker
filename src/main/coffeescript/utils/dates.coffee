define ['ember', 'mixins/comparable', 'utils/functions'], (Ember, Comparable, F) ->

	# The timezone math in this module doesn't work over a daylight savings time boundary.

	# Globally available (App.DATES) Date-related constants
	Dates = Ember.Object.create
		now: -> Day.create
			value: new Date().getTime()

		today: -> @morning(new Date().getTime())

		morning: (ms) -> Day.create
			value: Math.floor((ms - @get('localTimezoneMS')) / @intervals.days) * @intervals.days

		intervals:
			seconds: 1000
			minutes: 60*1000
			hours: 60*60*1000
			days: 24*60*60*1000
			weeks: 7*24*60*60*1000

		days: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

		localTimezoneMS: new Date().getTimezoneOffset() * 60*1000 # This doesn't cover DST changes

	Day = Ember.Object.extend Comparable,
		plus: (num, intervalName) ->
			ms = Dates.intervals[intervalName]
			if ms?
				Day.create
					value: @get('asMS') + num * ms
			else
				throw new Error(intervalName + ' is not an interval.')

		minus: (num, intervalName) -> @plus(-1 * num, intervalName)

		asDate: (-> new Date(@get('asMS'))).property('asMS')
		asMS: (-> @get('value')).property('value')

		year: (-> @get('asDate').getUTCFullYear()).property('asDate')
		month: (-> @get('asDate').getUTCMonth() + 1).property('asDate')
		date: (-> @get('asDate').getUTCDate()).property('asDate')
		humanDay: (-> Dates.days[@get('asDate').getUTCDay()]).property('asDate')

		compare: (otherDay) -> F.sign(@get('asMS') - otherDay.get('asMS'))

	Dates

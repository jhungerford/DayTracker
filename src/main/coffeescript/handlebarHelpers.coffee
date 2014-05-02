define ['ember'], (Ember) ->

	days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

	Ember.Handlebars.helper 'logDate', (value) ->
		# The timezone math in this helper doesn't work over a daylight savings time boundary.
		dayMS = 24 * 60 * 60 * 1000;
		now = new Date()
		timezoneMS = now.getTimezoneOffset() * 60 * 1000
		today = Math.floor((now.getTime()) / dayMS) * dayMS - timezoneMS

		if (value >= (today - dayMS))
			'Today'
		else if (value >= (today - 2 * dayMS))
			'Yesterday'
		else if (value >= (today - 3 * dayMS))
			'Two days ago'
		else if (value >= (today - 7 * dayMS))
			'Last ' + days[new Date(value).getDay()]
		else
			day = new Date(value)
			'On ' + (day.getUTCMonth() + 1) + '/' + day.getUTCDate()

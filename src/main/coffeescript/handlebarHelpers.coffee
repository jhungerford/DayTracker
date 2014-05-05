define ['ember'], (Ember) ->

	days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

	Ember.Handlebars.helper 'logDate', (value) ->
		# The timezone math in this helper doesn't work over a daylight savings time boundary.
		dayMS = 24 * 60 * 60 * 1000
		now = new Date()
		valueDate = new Date(value)

		timezoneMS = now.getTimezoneOffset() * 60 * 1000
		today = Math.floor((now.getTime() - timezoneMS) / dayMS) * dayMS + timezoneMS

		if (value >= (today + dayMS))
			'In the future'
		else if (value >= today)
			'Today'
		else if (value >= (today - dayMS))
			'Yesterday'
		else if (value >= (today - 2 * dayMS))
			'Two days ago'
		else if (value >= (today - 6 * dayMS))
			'Last ' + days[new Date(value).getDay()]
		else if (now.getFullYear() is new Date(value).getFullYear())
			'On ' + (valueDate.getUTCMonth() + 1) + '/' + valueDate.getUTCDate()
		else
			'On ' + (valueDate.getUTCMonth() + 1) + '/' + valueDate.getUTCDate() + '/' + valueDate.getUTCFullYear();

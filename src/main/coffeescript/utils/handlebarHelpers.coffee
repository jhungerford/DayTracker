define ['ember', 'app', 'utils/dates'], (Ember, App, Dates) ->
	Helpers =
		formatDate: (today, valueDay) ->
			if valueDay.gte(today.plus(1, 'days'))
				'In the future'
			else if valueDay.gte(today)
				'Today'
			else if valueDay.gte(today.minus(1, 'days'))
				'Yesterday'
			else if valueDay.gte(today.minus(2, 'days'))
				'Two days ago'
			else if valueDay.gte(today.minus(1, 'weeks'))
				'Last ' + valueDay.get('humanDay')
			else if valueDay.get('year') is today.get('year')
				'On ' + valueDay.get('month') + '/' + valueDay.get('date')
			else
				'On ' + valueDay.get('month') + '/' + valueDay.get('date') + '/' + valueDay.get('year')

	Ember.Handlebars.helper 'logDate', (valueDay) -> Helpers.formatDate(Dates.today(), valueDay)

	Helpers

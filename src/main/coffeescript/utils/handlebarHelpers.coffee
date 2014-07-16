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

	# http://emberjs.com/guides/cookbook/user_interface_and_interaction/focusing_a_textfield_after_its_been_inserted/
	App.FocusInputComponent = Ember.TextField.extend
		becomeFocused: ( ->
			input = @$()
			length = input.val().length

			do input.focus
			input[0].setSelectionRange(length, length) # Move the cursor to the end of the line.
			# TODO: should the cursor position be configurable?
		).on('didInsertElement')

	Helpers

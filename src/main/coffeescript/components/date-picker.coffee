define ['app', 'ember', 'utils/dates', 'text!/templates/components/date-picker.hbs'], (App, Ember, Dates, datePickerTemplate) ->
	App.registerTemplate 'components/date-picker', datePickerTemplate

	DatePickerDay = Ember.Object.extend
		date: Ember.computed.alias 'value.date'

	App.DatePickerComponent = Ember.Component.extend
		visibleDate: Ember.computed.defaultTo 'selectedDate'

		visibleMonth: Ember.computed.alias 'visibleDate.month'
		visibleYear: Ember.computed.alias 'visibleDate.year'

		weeks: (->
			visibleDate = @get('visibleDate')
			selectedDate = @get('selectedDate')

			startOfMonth = Dates.startOfMonth visibleDate

			date = visibleDate.minus (startOfMonth + visibleDate.get('date')), 'days'

			# 2 dimensional array of dates with 6 weeks and 7 days in a week.
			[0..5].map -> [0..6].map ->
				date = date.plus 1, 'days'

				DatePickerDay.create
					value: date
					selected: date.eq(selectedDate)
					currentMonth: date.get('month') is visibleDate.get('month')
		).property 'visibleDate', 'selectedDate'

		actions:
			select: (day) ->
				@set 'selectedDate', day
				@sendAction 'select', day

			previousMonth: -> @set 'visibleDate', @get('visibleDate').minus(1, 'months'); false
			nextMonth: -> @set 'visibleDate', @get('visibleDate').plus(1, 'months'); false

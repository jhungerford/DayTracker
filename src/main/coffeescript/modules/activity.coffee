define ['app', 'ember', 'utils/dates', 'utils/functions', 'text!/templates/activity.hbs', 'text!/templates/activityInput.hbs'], (App, Ember, Dates, F, activityTemplate, activityInputTemplate) ->
	App.registerTemplate 'activity', activityTemplate
	App.registerTemplate 'activityInput', activityInputTemplate

	App.ActivityController = Ember.ArrayController.extend
		groupByDay: (->
			morningOfTimestampProperty = (item) -> Dates.morning(item.timestamp)
			# Elements are sorted by timestamp - convert them into a list of lists of activities grouped by day
			groupedByDay = F.groupSorted(@, morningOfTimestampProperty, F.compareEq)
			# Turn each element in the list of lists of activities into an object for the view
			groupedByDay.map (activities) ->
				day: Dates.morning(activities[0].timestamp)
				activities: activities.map (activity) -> activity.text
		).property('@each.timestamp')

	App.ActivityInputController = Ember.Controller.extend
		actions:
			save: ->
				data = {timestamp: new Date().getTime(), text: @get('activity')}
				Ember.$.ajax(
					type: 'POST'
					url: '/api/v1/activity'
					contentType: 'application/json'
					dataType: 'json'
					data: JSON.stringify data
				).done =>
					@set('activity', '')
					false

	App.ActivityRoute = Ember.Route.extend
		model: -> Ember.$.getJSON('/api/v1/activity')

define ['app', 'ember', 'emberData', 'utils/dates', 'utils/functions', 'text!/templates/activities.hbs', 'text!/templates/activityInput.hbs'], (App, Ember, DS, Dates, F, activitiesTemplate, activityInputTemplate) ->
	App.registerTemplate 'activities', activitiesTemplate
	App.registerTemplate 'activityInput', activityInputTemplate

	App.Activity = DS.Model.extend
		timestamp: DS.attr 'number'
		text: DS.attr 'string'

	App.ActivitiesEditController = Ember.ObjectController.extend()

	App.ActivityController = Ember.ObjectController.extend
		needs: 'activitiesEdit'

		isEditing: (->
			@get('id') is @get('controllers.activitiesEdit.id')
		).property 'id', 'controllers.activitiesEdit.id'

		actions:
			edit: ->
				@transitionToRoute 'activities.edit', @get('id')
				false

	App.ActivitiesController = Ember.ArrayController.extend
		sortProperties: ['timestamp']
		sortAscending: false

		groupByDay: (->
			morningOfTimestampProperty = (item) -> Dates.morning(item.get('timestamp'))
			# Elements are sorted by timestamp - convert them into a list of lists of activities grouped by day
			groupedByDay = F.groupSorted(@, morningOfTimestampProperty, F.compareEq)
			# Turn each element in the list of lists of activities into an object for the view
			groupedByDay.map (activities) ->
				day: Dates.morning(activities[0].get('timestamp'))
				activities: activities
		).property('@each.timestamp')

	App.ActivityInputController = Ember.Controller.extend
		actions:
			save: ->
				activity = @get('store').createRecord 'activity',
					timestamp: new Date().getTime()
					text: @get('text')

				@set('text', '')
				do activity.save

	App.ActivitiesRoute = Ember.Route.extend
		model: -> @get('store').find('activity')

	App.ActivitiesEditRoute = Ember.Route.extend
		exit: -> @controllerFor('activitiesEdit').set('id', undefined)


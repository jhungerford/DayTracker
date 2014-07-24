define ['app', 'ember', 'emberData', 'utils/dates', 'utils/functions', 'text!/templates/activities.hbs', 'text!/templates/activityInput.hbs', 'text!/templates/activityEdit.hbs', 'text!/templates/activityEditTag.hbs', 'text!/templates/activityEditDelete.hbs', 'text!/templates/activityEditCalendar.hbs'],
(App, Ember, DS, Dates, F, activitiesTemplate, activityInputTemplate, activitiesEditTemplate, activityEditTagTemplate, activityEditDeleteTemplate, activityEditCalendarTemplate) ->
	App.registerTemplate 'activities', activitiesTemplate
	App.registerTemplate 'activityInput', activityInputTemplate
	App.registerTemplate 'activityEdit', activitiesEditTemplate
	App.registerTemplate 'activitiesEditTag', activityEditTagTemplate
	App.registerTemplate 'activitiesEditDelete', activityEditDeleteTemplate
	App.registerTemplate 'activitiesEditCalendar', activityEditCalendarTemplate

	App.Activity = DS.Model.extend
		timestamp: DS.attr 'number'
		text: DS.attr 'string'

	App.ActivityController = Ember.ObjectController.extend
		needs: 'activities'

		isEditing: (->
			@get('id') is @get('controllers.activities.selectedId')
		).property 'id', 'controllers.activities.selectedId'

		actions:
			save: ->
				@get('model').save().then => @transitionToRoute('activities')
				false
			# TODO: event should be editable immediately after it was created (bind id to the model?)
			# TODO: tab should move to the next event
			cancel: -> @transitionToRoute 'activities'; false
			toTag: -> @transitionToRoute 'activitiesEditTag', @get('id'); false
			toDelete: -> @transitionToRoute 'activitiesEditDelete', @get('id'); false
			toCalendar: -> @transitionToRoute 'activitiesEditCalendar', @get('id'); false

	App.ActivitiesController = Ember.ArrayController.extend
		sortProperties: ['timestamp']
		sortAscending: false

		groupByDay: (-> # TODO: should groupByDay return an ArrayProxy / SortableMixin of the days?
			morningOfTimestampProperty = (item) -> Dates.morning(item.get('timestamp'))
			# Elements are sorted by timestamp - convert them into a list of lists of activities grouped by day
			groupedByDay = F.groupSorted(@, morningOfTimestampProperty, F.compareEq)
			# Turn each element in the list of lists of activities into an object for the view
			groupedByDay.map (activities) ->
				day: Dates.morning(activities[0].get('timestamp'))
				activities: activities
		).property('@each.timestamp')

		actions:
			create: ->
				activity = @get('store').createRecord 'activity',
					timestamp: new Date().getTime()
					text: @get('text')

				@set('text', '')
				do activity.save

	App.ActivitiesRoute = Ember.Route.extend
		model: -> @get('store').find('activity')

	App.ActivitiesIndexRoute = Ember.Route.extend
		setupController: (controller, model) ->
			@_super(controller, model)
			@controllerFor('activities').set('selectedId', null)

	App.ActivitiesEditRoute = Ember.Route.extend
		model: (params) -> @get('store').find('activity', params.id)
		setupController: (controller, model) ->
			@_super(controller, model)
			@controllerFor('activities').set('selectedId', model.get('id'))

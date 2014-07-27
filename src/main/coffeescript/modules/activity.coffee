define ['app', 'ember', 'emberData', 'utils/dates', 'utils/functions', 'text!/templates/activities.hbs', 'text!/templates/activityInput.hbs', 'text!/templates/activityEdit.hbs', 'text!/templates/activityEditTag.hbs', 'text!/templates/activityEditDelete.hbs', 'text!/templates/activityEditCalendar.hbs'],
(App, Ember, DS, Dates, F, activitiesTemplate, activityInputTemplate, activitiesEditTemplate, activityEditTagTemplate, activityEditDeleteTemplate, activityEditCalendarTemplate) ->
	App.registerTemplate 'activities', activitiesTemplate
	App.registerTemplate 'activityInput', activityInputTemplate
	App.registerTemplate 'activityEdit', activitiesEditTemplate
	App.registerTemplate 'activityEditTag', activityEditTagTemplate
	App.registerTemplate 'activityEditDelete', activityEditDeleteTemplate
	App.registerTemplate 'activityEditCalendar', activityEditCalendarTemplate

	App.Activity = DS.Model.extend
		timestamp: DS.attr 'number'
		text: DS.attr 'string'

	App.ActivityController = Ember.ObjectController.extend
		needs: 'activities'

		date: (-> Dates.morning(@get('timestamp')) ).property('timestamp')

		isEditing: (->
			id = @get('id')
			id? and id is @get('controllers.activities.selectedId')
		).property 'id', 'controllers.activities.selectedId'

		isEditTag: (-> @get('controllers.activities.editType') is 'tag' ).property 'isEditing', 'controllers.activities.editType'
		isEditDelete: (-> @get('controllers.activities.editType') is 'delete' ).property 'isEditing', 'controllers.activities.editType'
		isEditCalendar: (-> @get('controllers.activities.editType') is 'calendar' ).property 'isEditing', 'controllers.activities.editType'

		actions:
			save: ->
				@get('model').save().then => @transitionToRoute('activities')
				false
			changeDate: (newDate) ->
				# newDate is a morning - subtract the day difference in days to preserve the activity time.
				activity = @get('model')
				activityMS = activity.get('timestamp')
				dayOffset = Dates.morning(activityMS).get('asMS') - newDate.get('asMS')
				activity.set('timestamp', activityMS - dayOffset)
				activity.save().then => @transitionToRoute('activities')
				false
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
			toEdit: (id) -> @transitionToRoute 'activitiesEdit', id; false

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

	BaseActivitiesEditRoute = Ember.Route.extend
		editType: null
		setupController: (controller, model) ->
			@_super(controller, model)
			@controllerFor('activities').set('editType', @get('editType'))

	App.ActivitiesEditIndexRoute = BaseActivitiesEditRoute.extend
		editType: null

	App.ActivitiesEditTagRoute = BaseActivitiesEditRoute.extend
		editType: 'tag'

	App.ActivitiesEditDeleteRoute = BaseActivitiesEditRoute.extend
		editType: 'delete'

	App.ActivitiesEditCalendarRoute = BaseActivitiesEditRoute.extend
		editType: 'calendar'

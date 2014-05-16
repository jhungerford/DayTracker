define ['app', 'ember', 'text!/templates/activity.hbs', 'text!/templates/activityInput.hbs'], (App, Ember, activityTemplate, activityInputTemplate) ->
	App.registerTemplate 'activity', activityTemplate
	App.registerTemplate 'activityInput', activityInputTemplate

	App.ActivityController = Ember.ArrayController.extend()

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
		model: ->
			timezoneOffsetMS = new Date().getTimezoneOffset() * 60 * 1000
			Ember.$.getJSON('/api/v1/activity/days') # ?tzms=' + timezoneOffsetMS

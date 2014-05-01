define ['app', 'ember', 'text!/templates/application.hbs'], (App, Ember, template) ->
	App.registerTemplate 'application', template

	App.ApplicationRoute = Ember.Route.extend
		model: ->
			Ember.$.getJSON('/api/v1/days').then (data) -> data

define ['app', 'ember', 'text!/templates/application.hbs'], (App, Ember, applicationTemplate) ->
	App.registerTemplate 'application', applicationTemplate

	App.ApplicationRoute = Ember.Route.extend
		beforeModel: -> @transitionTo '/activities'

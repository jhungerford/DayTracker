define ['ember', 'emberData'], (Ember, DS) ->
	window.App = App = Ember.Application.create
		LOG_TRANSITIONS: true

	App.registerTemplate = (name, template) ->
		Ember.TEMPLATES[name] = Ember.Handlebars.compile(template)

	App

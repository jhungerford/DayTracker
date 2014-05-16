define ['app', 'modules/application', 'modules/activity'], (App) ->
	App.Router.map( ->
		@resource 'activity'
	)

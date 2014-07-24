define ['app', 'modules/application', 'modules/activity'], (App) ->
	App.Router.map( ->
		@resource 'activities', ->
			@resource 'activitiesEdit', {path: '/:id/edit'}, ->
				@resource 'activitiesEditTag', {path: '/tag'},
				@resource 'activitiesEditCalendar', {path: '/calendar'},
				@resource 'activitiesEditDelete', {path: '/delete'}
	)

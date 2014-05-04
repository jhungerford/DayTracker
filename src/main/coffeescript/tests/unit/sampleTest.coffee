define ['app', 'ember'], (App, Ember) ->
	App.SomeThing = Ember.Object.extend
		foo: 'bar'
		computedFoo: ( -> 'computed ' + @get('foo')).property('foo')

	run = ->
		module 'Unit: sampleTest'

		test "hello test", ->
			ok true, "Passed!"
		test "another test", ->
			ok (1+1 is 2), "1+1 = 2"
		test "failing test", ->
			ok false, "This should fail - false isn't true."
		test 'computedFoo correctly concats foo', ->
			someThing = App.SomeThing.create()
			someThing.set 'foo', 'baz'
			equal someThing.get('computedFoo'), 'computed baz'

	{run: run}

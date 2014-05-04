define ['qUnit'], ->
	run = ->
		test "hello test", ->
			ok true, "Passed!"
		test "another test", ->
			ok (1+1 is 2), "1+1 = 2"
		test "failing test", ->
			ok false, "This should fail - false isn't true."

	{run: run}

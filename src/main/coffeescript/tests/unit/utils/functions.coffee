define ['ember', 'utils/functions'], (Ember, F) ->
	zero = {value: 0}
	one = {value: 1}
	two = {value: 2}
	three = {value: 3}
	oneTwoThree = Ember.ArrayController.create({model: [one, two, three]})
	valueProp = (obj) -> obj.value

	run: ->
		module 'Unit: utils/functions'

		test 'groupSorted', ->
			arrController = Ember.ArrayController.create({model: [1, 3, 2, 4, 5, 6]})
			grouped = F.groupSorted(arrController, F.identity, F.sameParity)
			expected = [[1, 3], [2, 4], [5], [6]]
			equal JSON.stringify(grouped), JSON.stringify(expected)

		test 'sumReduction', ->
			equal F.sum(oneTwoThree, valueProp), 6

		test 'winner', ->
			equal oneTwoThree.reduce(F.winner(valueProp, F.gt), zero).value, 3

		test 'compareFilter', ->
			result = oneTwoThree.filter(F.compareFilter(valueProp, F.odd))
			expected = [one, three]
			equal JSON.stringify(result), JSON.stringify(expected)

		test 'compareValue', ->
			result = oneTwoThree.filter(F.compareFilter(valueProp, F.compareValue(F.gt, 1)))
			expected = [two, three]
			equal JSON.stringify(result), JSON.stringify(expected)

		test 'even', ->
			expect 3
			equal F.even(0), true
			equal F.even(1), false
			equal F.even(2), true

		test 'odd', ->
			expect 3
			equal F.odd(0), false
			equal F.odd(1), true
			equal F.odd(2), false

		test 'sameParity', ->
			expect 2
			equal F.sameParity(1, 3), true
			equal F.sameParity(1, 4), false

		test 'identity', ->
			expect 2
			equal F.identity(1), 1
			item = {value: 1}
			equal F.identity(item), item

		test 'prop', ->
			a = Ember.Object.create({letter: 'a'})
			equal F.prop('letter')(a), 'a'

		test 'sign', ->
			expect 5
			equal F.sign(214), 1
			equal F.sign(1), 1
			equal F.sign(0), 0
			equal F.sign(-1), -1
			equal F.sign(-512), -1

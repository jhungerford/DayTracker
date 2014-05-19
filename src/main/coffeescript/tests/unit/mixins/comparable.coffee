define ['ember', 'mixins/comparable', 'utils/functions'], (Ember, Comparable, F) ->
	Num = Ember.Object.extend Comparable,
		value: 0
		compare: (other) -> F.sign(@get('value') - other.get('value'))

	run: ->
		one = Num.create
			value: 1
		two = Num.create
			value: 2

		module 'Unit: mixins/comparable'

		test 'compare', ->
			expect(3)
			equal one.compare(one), 0
			equal one.compare(two), -1
			equal two.compare(one), 1

		test 'lt', ->
			expect(3)
			ok one.lt(two)
			ok not two.lt(one)
			ok not one.lt(one)

		test 'gt', ->
			expect(3)
			ok not one.gt(two)
			ok two.gt(one)
			ok not one.gt(one)

		test 'eq', ->
			expect(2)
			ok one.eq(one)
			ok not one.eq(two)

		test 'lte', ->
			expect(3)
			ok one.lte(two)
			ok not two.lte(one)
			ok one.lte(one)

		test 'gte', ->
			expect(3)
			ok not one.gte(two)
			ok two.gte(one)
			ok one.gte(one)

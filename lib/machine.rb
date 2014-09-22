require './lib/coins'
require './lib/product'
require_relative 'helpers'

# requires added only to try it faster in irb

class Machine

	include Helpers

	attr_accessor :coins

	def initialize
		# machine is initialized with some products and some coins
		@coke = Product.new "Coke", 150.0, 10
		@pringles = Product.new "Pringles", 50.0, 5
		@mars = Product.new "Mars", 175.0, 5
		@coins = Coins.new 5, 5, 5, 5, 5, 5, 2, 2
	end

	def products
		[@coke, @pringles, @mars]
	end

	def buy(product, amount)
		# main method to buy products
		new_amount = convert(amount)

		return incorrect_message if incorrect?(amount)

		return not_available_message if not_available(product)

		return no_more_message(product) if no_more(product)
		
		if correct_amount?(product, new_amount)
			return_product_stack_amount(product, amount)
			return return_product_stack_amount_message(product)
		end

		if too_much_money?(product, new_amount)
			return_product_and_change(product, amount)
			return return_product_and_change_message(product)
		end

		if money_not_enough?(product, new_amount)
			return_nothing(product, amount)
			return ask_for_more
		end
	end

	def add(remaining_amount, product)
		# to add more money if the payment is not enough.
		# removes one item from the machine and adds coins to the stack
		selected(product).one_less
		@coins.receive(convert(@temporary))
		@coins.receive(remaining_amount)
	end

	def reload
		initialize
	end

	def available_coins
		# returns a list of all the coins in the machine
		@machine_coins = []
		index = 0
		@coins.values.each do |value|
			@coins.coins_quantity[index].times { @machine_coins << value}
			index += 1
		end
		@machine_coins
	end

	def products_names
		products.map{|product| product.name}
	end

	def select(product)
		products.select{|prod| prod.name == product}
	end

	def selected(product)
		@selected = select(product)[0]
	end

	def name(product)
		# returns the name of the product selected
		selected(product).name
	end

	def quantity(product)
		prod = select(product)
		prod[0].quantity
	end

	def price(product)
		prod = select(product)
		prod[0].price
	end

	def remaining(product)
		selected(product).quantity
	end

end
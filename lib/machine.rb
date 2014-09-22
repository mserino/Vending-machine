require './lib/coins'
require './lib/product'
require_relative 'helpers'

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


	## BUY METHODS
		def incorrect?(amount)
		!amount.include?("p") && !amount.include?("£")
	end

	def incorrect_message
		"Please insert the money in the correct way (e.g. 50p or £1)"
	end

	def not_available(product)
		!products_names.include?(product)
	end

	def not_available_message
		"This item is not available"
	end

	def no_more(product)
		remaining(product) == 0
	end

	def no_more_message(product)
		"There are no more #{selected(product).name}"
	end

	def correct_amount?(product, new_amount)
		new_amount == price(product)
	end

	def too_much_money?(product, new_amount)
		new_amount > price(product)
	end

	def money_not_enough?(product, new_amount)
		new_amount < price(product)
	end

	def return_product_stack_amount(product, amount)
		selected(product).one_less
		@coins.receive(amount)
	end

	def return_product_stack_amount_message(product)
		"Your product: #{name(product)}"
	end

	def return_product_and_change(product, amount)
		# payment added to the stack
		new_amount = convert(amount)
		@change = convert(new_amount - price(product))
		selected(product).one_less
		@coins.receive(convert(price(product)))
	end

	def return_product_and_change_message(product)
		"Your product: #{selected(product).name} - Change: #{@change}"
	end

	def return_nothing(product, amount)
		# if the money is not enough, the money inserted is added to a temporary stock
		new_amount = convert(amount)
		@remaining = price(product) - new_amount
		@temporary = new_amount
	end

	def ask_for_more
		"Please insert another #{convert(@remaining)}"
	end
	## END BUY METHODS

end
require './lib/coins'
require './lib/product'
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
		# list of all the products objects in the machine
		[@coke, @pringles, @mars]
	end

	def buy(product, amount)
		# main method to buy products
		new_amount = convert(amount)

		# returns an error message if payment is typed incorrectly
		return incorrect_message if incorrect?(amount)

		# returns an error message if the item is not in the machine
		return not_available_message if not_available(product)

		# returns an error message if there are no more items of the kind selected
		return no_more_message(product) if no_more(product)
		
		# returns the product if the request is correct, adds coin to the stack and removes one item from the machine
		if correct_amount?(product, new_amount)
			return_product_stack_amount(product, amount)
			return return_product_stack_amount_message(product)
		end

		# returns the product and the change if the amount inserted is more than the price of the object
		# removes on item from the machine and adds coins to the stack
		if too_much_money?(product, new_amount)
			return_product_and_change(product, amount)
			return return_product_and_change_message(product)
		end

		# doesn't return anything if the payment is not enough, but asks for more money (next method - add)
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
		# reloads products and coins
		initialize
	end

	def incorrect?(amount)
		# checks if the params of the amount is correctly typed
		!amount.include?("p") && !amount.include?("£")
	end

	def incorrect_message
		# error message if typed incorrectly
		"Please insert the money in the correct way (e.g. 50p or £1)"
	end

	def not_available(product)
		# checks if the selected product is available in the machine
		!products_names.include?(product)
	end

	def not_available_message
		# error message if the product is not available
		"This item is not available"
	end

	def no_more(product)
		# checks if the selected product is over
		remaining(product) == 0
	end

	def no_more_message(product)
		# message if the selected product is over
		"There are no more #{selected(product).name}"
	end

	def correct_amount?(product, new_amount)
		# checks if the amount is correct
		new_amount == price(product)
	end

	def too_much_money?(product, new_amount)
		# checks if too much money is inserted
		new_amount > price(product)
	end

	def money_not_enough?(product, new_amount)
		# check if the money is not enough
		new_amount < price(product)
	end

	def return_product_stack_amount(product, amount)
		# one product less from the machine
		# payment added to the stack
		selected(product).one_less
		@coins.receive(amount)
	end

	def return_product_stack_amount_message(product)
		# returns a message with the product
		"Your product: #{name(product)}"
	end

	def return_product_and_change(product, amount)
		# one product less from the machine
		# payment added to the stack
		new_amount = convert(amount)
		@change = convert(new_amount - price(product))
		selected(product).one_less
		@coins.receive(convert(price(product)))
	end

	def return_product_and_change_message(product)
		# returns a message with the product and change
		"Your product: #{selected(product).name} - Change: #{@change}"
	end

	def return_nothing(product, amount)
		# if the money is not enough, the money inserted is added to a temporary stock
		new_amount = convert(amount)
		@remaining = price(product) - new_amount
		@temporary = new_amount
	end

	def ask_for_more
		# message asking for more money
		"Please insert another #{convert(@remaining)}"
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
		# returns a list with the names of all the products
		products.map{|p| p.name}
	end

	def select(product)
		# selects the product inside the machine
		products.select{|p| p.name == product}
	end

	def selected(product)
		# selects the product inside the array resulting from the select(product) method
		@selected = select(product)[0]
	end

	def name(product)
		# returns the name of the product selected
		selected(product).name
	end

	def quantity(product)
		# returns a number with the available quantity of the products in the machine
		q = select(product)
		q[0].quantity
	end

	def price(product)
		# returns the price of the selected product
		p = select(product)
		p[0].price
	end

	def remaining(product)
		# returns the number of the remaining selected product in the machine
		selected(product).quantity
	end

end
class Machine

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
		return "Please insert the money in the correct way (e.g. 50p or £1)" if !amount.include?("p") && !amount.include?("£")

		# returns an error message if the item is not in the machine
		return "This item is not available" if !products_names.include?(product)

		# returns an error message if there are no more items of the kind selected
		return "There are no more #{selected(product).name}" if remaining(product) == 0
		
		if new_amount == price(product)
			# returns the product if the request is correct, adds coin to the stack and removes one item from the machine
			selected(product).one_less
			@coins.receive(amount)
			return "Your product: #{selected(product).name}" 
		end

		if new_amount > price(product)
			# returns the product and the change if the amount inserted is more than the price of the object
			# removes on item from the machine and adds coins to the stack
			change = convert(new_amount - price(product))
			selected(product).one_less
			@coins.receive(convert(price(product)))
			return "Your product: #{selected(product).name} - Change: #{change}"
		end

		if new_amount < price(product)
			# doesn't return anything if the payment is not enough, but asks for more money (next method - add)
			remaining = price(product) - new_amount
			@temporary = new_amount
			return "Please insert another #{convert(remaining)}"
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
		@coins.one_p.times{ @machine_coins << 1}
		@coins.two_p.times{ @machine_coins << 2}
		@coins.five_p.times{ @machine_coins << 5}
		@coins.ten_p.times{ @machine_coins << 10}
		@coins.twenty_p.times{ @machine_coins << 20}
		@coins.fifty_p.times{ @machine_coins << 50}
		@coins.one_pound.times{ @machine_coins << 100}
		@coins.two_pounds.times{ @machine_coins << 200}
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

	def convert(cash)
		# converts string in float and viceversa
		if cash.class == String
			return cash.to_f if cash.include? "p"
			return (cash.delete("£").to_f)*100 if cash.include? "£"
		end

		if cash.class == Float || cash.class == Fixnum
			return "#{cash.to_i}p" if cash < 100
			return "£#{cash.to_i/100}" if cash >= 100
		end
	end

end
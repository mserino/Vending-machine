require './lib/coins'
require './lib/product'

class Machine

	attr_accessor :coins

	def initialize
		@coke = Product.new "Coke", 150.0, 10
		@pringles = Product.new "Pringles", 50.0, 5
		@mars = Product.new "Mars", 175.0, 5
		@coins = Coins.new 5, 5, 5, 5, 5, 5, 2, 2
	end

	def products
		[@coke, @pringles, @mars]
	end

	def available_coins
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
		products.map{|p| p.name}
	end

	def select(product)
		products.select{|p| p.name == product}
	end

	def selected(product)
		@selected = select(product)[0]
	end

	def quantity(product)
		q = select(product)
		q[0].quantity
	end

	def price(product)
		p = select(product)
		p[0].price
	end

	def remaining(product)
		selected(product).quantity
	end

	def buy(product, amount)
		new_amount = convert(amount)

		return "Please insert the money in the correct way (e.g. 50p or £1)" if !amount.include?("p") && !amount.include?("£")

		return "This item is not available" if !products_names.include?(product)

		return "There are no more #{selected(product).name}" if remaining(product) == 0
		
		if new_amount == price(product)
			selected(product).one_less
			@coins.receive(amount)
			return "Your product:\n #{selected(product).name}" 
		end

		if new_amount > price(product)
			change = convert(new_amount - price(product))
			selected(product).one_less
			@coins.receive(convert(price(product)))
			return "Your product:\n #{selected(product).name}\nChange: #{change}"
		end

		if new_amount < price(product)
			remaining = price(product) - new_amount
			@temporary = new_amount
			return "Please insert another #{convert(remaining)}"
		end
	end

	def add(remaining_amount, product)
		selected(product).one_less
		@coins.receive(convert(@temporary))
		@coins.receive(remaining_amount)
	end

	def convert(cash)
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
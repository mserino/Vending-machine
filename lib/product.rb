class Product
	def initialize(name, price, quantity)
		@name = name
		@price = price
		@quantity = quantity
	end

	def name
		@name
	end

	def price
		@price
	end

	def quantity
		@quantity
	end

	def one_less
		return "No more #{self.name}" if @quantity == 0
		@quantity -= 1
	end
end
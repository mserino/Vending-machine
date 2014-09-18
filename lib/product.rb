class Product

	attr_accessor :name, :price, :quantity

	def initialize(name, price, quantity)
		# product is initialized with a name, price and quantity
		@name = name
		@price = price
		@quantity = quantity
	end

	def one_less
		# removes one item from the quantity, returns a message is the quantity is zero
		return "No more #{self.name}" if @quantity == 0
		@quantity -= 1
	end
end
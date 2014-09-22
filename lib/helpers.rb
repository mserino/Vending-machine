module Helpers

	def convert(cash)
		# converts string in float and viceversa
		if is_a_string?(cash)
			return penny_to_float(cash) if is_penny?(cash)
			return pounds_to_float(cash) if is_pound?(cash)
		end

		if is_a_float?(cash) || is_a_fixnum?(cash)
			return penny_to_string(cash) if less_than_100(cash)
			return pounds_to_string(cash) if more_equal_100(cash)
		end
	end

	## CONVERT METHODS
	def pounds_to_string(cash)
		"£#{cash.to_i/100}"
	end

	def penny_to_string(cash)
		"#{cash.to_i}p"
	end

	def less_than_100(cash)
		cash < 100
	end

	def more_equal_100(cash)
		cash >= 100
	end

	def penny_to_float(cash)
		cash.to_f
	end

	def pounds_to_float(cash)
		(cash.delete("£").to_f)*100
	end


	def is_pound?(cash)
		cash.include? "£"
	end

	def is_penny?(cash)
		cash.include? "p"
	end

	def is_a_string?(object)
		object.class == String
	end

	def is_a_float?(object)
		object.class == Float
	end

	def is_a_fixnum?(object)
		object.class == Fixnum
	end
	## END CONVERT METHODS


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
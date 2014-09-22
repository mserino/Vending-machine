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
end
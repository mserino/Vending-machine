class Machine

	def products
		{"Coke" => 2,
		 "Mars" => 3,
		 "Pringles" => 4}
	end

	def change
		{
			"1p" => nil,
			"2p" => nil,
			"5p" => nil,
			"10p" => nil,
			"20p" => nil,
			"50p" => nil,
			"£1" => nil,
			"£2" => nil
		}
	end

	def price(product)
		products[product]
	end

	def select(product)
		return product
	end
end
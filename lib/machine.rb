class Machine

	def products
		[
			{product: {"Coke" => 150.0}, quantity: nil},
			{product: {"Mars" => 50.0}, quantity: nil},
			{product: {"Pringles" => 175.0}, quantity: nil}
		]
	end

	def products_names
		products.map{|p| p[:product].keys}.flatten
	end

	def change
		{
			"1p" => 10,
			"2p" => 10,
			"5p" => 10,
			"10p" => 10,
			"20p" => 8,
			"50p" => 8,
			"£1" => 5,
			"£2" => 5
		}
	end

	def price(product)
		p = products.select{|p| p[:product][product]}
		p[0][:product][product]
	end

	def convert(price)
		if price.class == Fixnum || price.class == Float
			return "#{price.to_i}p" if price < 100
			return "£#{price.to_i/100}" if price >= 100
		end

		if price.class == String
			return price.to_f if price.include? "p"
			return (price.delete("£").to_f)*100 if price.include? "£"
		end
	end

	def select(product, price)
		new_price = convert(price)
		if new_price == price(product)
			return "Your product: " + product
		end

		if new_price > price(product)
			change = convert(new_price - price(product))
			return "Your product: #{product} - Change: #{change}"
		end
	end

end
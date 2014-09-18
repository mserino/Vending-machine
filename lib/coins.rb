class Coins

	attr_accessor :one_p, :two_p, :five_p, :ten_p, :twenty_p, :fifty_p, :one_pound, :two_pounds

	def initialize(one_p, two_p, five_p, ten_p, twenty_p, fifty_p, one_pound, two_pounds)
		# coins class initialized with all the denominations (£)
		@one_p = one_p
		@two_p = two_p
		@five_p = five_p
		@ten_p = ten_p
		@twenty_p = twenty_p
		@fifty_p = fifty_p
		@one_pound = one_pound
		@two_pounds = two_pounds
		@total = total
	end

	def values
		# all the values relative to every denomination
		{"1p" => 1, "2p" => 2, "5p" => 5, "10p" => 10, "20p" => 20, "50p" => 50, "£1" => 100, "£2" => 200}
	end

	def total
		# total amount of money in the machine
		(@one_p * values["1p"]) + (@two_p * values["2p"]) + (@five_p * values["5p"]) + (@ten_p * values["10p"]) + (@twenty_p * values["20p"]) + (@fifty_p * values["50p"]) + (@one_pound * values["£1"]) + (@two_pounds * values["£2"])
	end

	def receive(cash)
		# main method to add coins to the machine
		c = convert(cash)
		amount = change(c)
			amount.each do |coin|
				@one_p += 1 if coin == 1
				@two_p += 1 if coin == 2
				@five_p += 1 if coin == 5
				@ten_p += 1 if coin == 10
				@twenty_p += 1 if coin == 20
				@fifty_p += 1 if coin == 50
				@one_pound += 1 if coin == 100
				@two_pounds += 1 if coin == 200
			end
			@total = total
	end

	def convert(cash)
		# converts string into float and viceversa
		if cash.class == String
			return cash.to_f if cash.include? "p"
			return (cash.delete("£").to_f)*100 if cash.include? "£"
		end

		if cash.class == Float || cash.class == Fixnum
			return "#{cash.to_i}p" if cash < 100
			return "£#{cash.to_i/100}" if cash >= 100
		end
	end

  def change(amount)
  	# given a fixnum or a float, returns an array with all the coins that form the number
    available_coins = values.values.reverse
    coins = []
    index = 0
    coin = available_coins[index]
    remaining_amount = amount
    until remaining_amount == 0
      until remaining_amount >= coin
         index += 1
         coin = available_coins[index]
      end
      coins << coin
      remaining_amount -= coin
    end
    coins
  end

end
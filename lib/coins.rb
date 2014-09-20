require 'helpers'

class Coins

	include Helpers

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

	def coins_quantity
		# quantity of single coin in the stack
		[@one_p, @two_p, @five_p, @ten_p, @twenty_p, @fifty_p, @one_pound, @two_pounds]
	end

	def values
		# all the values relative to every denomination
		[1, 2, 5, 10, 20, 50, 100, 200]
	end

	def relative_values
		[{@one_p => 1}, {@two_p => 2}, {@five_p => 5}, {@ten_p => 10}, {@twenty_p => 20}, {@fifty_p => 50}, {@one_pound => 100}, {@two_pounds => 200}]
	end

	def couples
		# combines coins quantity and values
		coins_quantity.zip(values)
	end

	def total
		# total amount of money in the machine
		couples.map{|x,y| x*y}.inject(:+)
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

  def change(amount)
  	# given a fixnum or a float, returns an array with all the coins that form the number
    available_coins = values.reverse
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
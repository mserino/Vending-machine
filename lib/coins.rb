require_relative 'helpers'

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
		[@one_p, @two_p, @five_p, @ten_p, @twenty_p, @fifty_p, @one_pound, @two_pounds]
	end

	def values
		# all the values relative to every denomination
		[1, 2, 5, 10, 20, 50, 100, 200]
	end

	def couples
		coins_quantity.zip(values)
	end

	def total
		couples.map{|x,y| x*y}.inject(:+)
	end

	def relative_values
		{1 => :@one_p, 2 => :@two_p, 5 => :@five_p, 10 => :@ten_p, 20 => :@twenty_p, 50 => :@fifty_p, 100 => :@one_pound, 200 => :@two_pounds}
	end

	def receive(cash)
		# main method to add coins to the machine
		c = convert(cash)
		amount = change(c)
			amount.each do |coin|
				value = relative_values.fetch(coin)
				instance = self.instance_variable_get(value)
				self.instance_variable_set(value, instance += 1)
			end
			@total = total
	end

  def change(amount)
  	# given a fixnum or a float, returns an array with all the coins that form the number
    available_coins = values.reverse
    coins = []
    index = 0
    coin = available_coins[index]
    until amount == 0
      until amount >= coin
         index += 1
         coin = available_coins[index]
      end
      coins << coin
      amount -= coin
    end
    coins
  end

end
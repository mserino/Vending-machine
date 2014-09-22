class InvalidEnterException < Exception
	def initialize(msg="Please insert the money in the correct way (e.g. 50p or £1)")
		super(msg)
	end
end

class	ItemNotAvailableException < Exception
	def initialize(msg="The item is not available")
		super(msg)
	end
end

class	NoMoreException < Exception
	def initialize(msg="There are no more items of the kind you selected.")
		super(msg)
	end
end
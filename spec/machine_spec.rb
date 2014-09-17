require 'machine'
require 'product'

describe Machine do
	let(:machine) { Machine.new }
	let(:coke) { Product.new "Coke", 150.0, 10}
	let(:pringles) { Product.new "Pringles", 50.0, 5}
	let(:mars) { Product.new "Mars", 175.0, 5}

	context 'When created' do 
		it 'contains products when created' do
			expect(machine.products_names).to eq ["Coke", "Pringles", "Mars"]
		end

		it 'products have a price' do
			expect(machine.price("Coke")).to eq 150
		end

	# 	it 'contains change when created' do
	# 		expect(machine.change.keys).to eq ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
	# 	end

	# 	it 'contains 10 coins of denomination 1p' do
	# 		expect(machine.change["1p"]).to eq 10
	# 	end

	# 	it 'contains 10 coins of denomination 2p' do
	# 		expect(machine.change["2p"]).to eq 10
	# 	end

	# 	it 'contains 10 coins of denomination 5p' do
	# 		expect(machine.change["5p"]).to eq 10
	# 	end

	# 	it 'contains 10 coins of denomination 10p' do
	# 		expect(machine.change["10p"]).to eq 10
	# 	end

	# 	it 'contains 8 coins of denomination 20p' do
	# 		expect(machine.change["20p"]).to eq 8
	# 	end

	# 	it 'contains 8 coins of denomination 50p' do
	# 		expect(machine.change["50p"]).to eq 8
	# 	end

	# 	it 'contains 5 coins of denomination £1' do
	# 		expect(machine.change["£1"]).to eq 5
	# 	end

	# 	it 'contains 5 coins of denomination £2' do
	# 		expect(machine.change["£2"]).to eq 5
	# 	end

	# 	it 'contains 10 cans of coke' do
	# 		expect(machine.quantity("Coke")).to eq 10
	# 	end

	# 	it 'contains 5 Mars bars' do
	# 		expect(machine.quantity("Mars")).to eq 5
	# 	end

	# 	it 'contains 5 packs of Pringles' do
	# 		expect(machine.quantity("Pringles")).to eq 5
	# 	end
	end

	context 'Converting change' do
		it 'can convert price to denomination p' do
			expect(machine.convert(20)).to eq "20p"
		end

		it 'can convert price to denomination £' do
			expect(machine.convert(100)).to eq "£1"
		end

		it 'can convert denomination p to price' do
			expect(machine.convert("20p")).to eq 20
		end

		it 'can convert denomination £ to price' do
			expect(machine.convert("£1")).to eq 100
		end
	end

	context 'Selecting products' do
		it 'returns a product and no money if the money provided is correct' do
			expect(machine.buy("Coke", "£1.5")).to eq "Your product:\n Coke"
		end

		it 'returns change if too much money is provided' do
			expect(machine.buy("Coke", "£2")).to eq  "Your product:\n Coke\nChange: 50p"
		end

		# it 'asks for more money if is not enough' do
		# 	expect(machine.buy("Pringles", "£1")).to eq "Please insert another 75p"
		# end
	end

	context 'Keeping track of products and change' do
		it 'knows when a product is selected and is removed from the machine' do
			machine.buy("Coke", "£1.5")
			expect(machine.remaining("Coke")).to eq 9
		end

		it 'knows when a product is selected but is not removed from the stack if the money is not enough' do
			machine.buy("Pringles", "£1")
			expect(machine.remaining("Pringles")).to eq 5
		end

		it 'knows when there are no more items of a product' do
			5.times { machine.buy("Pringles", "50p") }
			expect(machine.buy("Pringles", "50p")).to eq "There are no more Pringles"
		end
	end

end
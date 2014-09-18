require 'machine'
require 'product'
require 'coins'

describe Machine do
	let(:machine) { Machine.new }

	context 'When created' do 
		it 'contains products when created' do
			expect(machine.products_names).to eq ["Coke", "Pringles", "Mars"]
		end

		it 'products have a price' do
			expect(machine.price("Coke")).to eq 150
		end

		it 'contains coins when created' do
			expect(machine.available_coins).to eq [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 5, 5, 5, 5, 5, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 50, 50, 50, 50, 50, 100, 100, 200, 200]
		end
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

		it 'adds the value to the total coins' do
			machine.buy("Coke", "£1.5")
			expect(machine.coins.fifty_p).to eq 6
			expect(machine.coins.one_pound).to eq 3
			expect(machine.coins.total).to eq 1190
		end

		it 'if there is change, only the right amount of money is cashed in the machine' do
			machine.buy("Pringles", "£1")
			expect(machine.coins.one_pound).to eq 2
			expect(machine.coins.fifty_p).to eq 6
		end

		it 'the item is removed from the stack if there is change' do
			machine.buy("Pringles", "£1")
			expect(machine.remaining("Pringles")).to eq 4
		end

		it 'asks for more money if is not enough' do
			expect(machine.buy("Mars", "£1")).to eq "Please insert another 75p"
		end

		it 'doesn\'t cash money or return the product until the remaining is added' do
			machine.buy("Mars", "£1")
			expect(machine.remaining("Mars")).to eq 5
			machine.add("75p", "Mars")
			expect(machine.remaining("Mars")).to eq 4
			expect(machine.coins.one_pound).to eq 3
			expect(machine.coins.fifty_p).to eq 6
		end
	end

	context 'Keeping track of products and change' do
		it 'knows when a product is selected and is removed from the machine' do
			machine.buy("Coke", "£1.5")
			expect(machine.remaining("Coke")).to eq 9
		end

		it 'knows when a product is selected but is not removed from the stack if the money is not enough' do
			machine.buy("Pringles", "30p")
			expect(machine.remaining("Pringles")).to eq 5
		end

		it 'knows when there are no more items of a product' do
			5.times { machine.buy("Pringles", "50p") }
			expect(machine.buy("Pringles", "50p")).to eq "There are no more Pringles"
		end
	end

end
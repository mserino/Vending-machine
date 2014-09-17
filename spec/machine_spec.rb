require 'machine'

describe Machine do
	let(:machine) { Machine.new }

	it 'contains products when created' do
		expect(machine.products.keys).to eq ["Coke", "Mars", "Pringles"]
	end

	it 'products have a price' do
		expect(machine.price("Coke")).to eq 2
	end

	it 'contains change when created' do
		expect(machine.change.keys).to eq ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
	end

	it 'returns a product when selected' do
		expect(machine.select("Coke")).to eq "Coke"
	end

end
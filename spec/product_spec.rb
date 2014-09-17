require 'product'

describe Product do
	let(:product) { Product.new "Coke", 150.0, 10}
	it 'has a name when initialized' do
		expect(product.name).to eq "Coke"
	end

	it 'has a price when initialized' do
		expect(product.price).to eq 150.0
	end

	it 'has a quantity' do
		expect(product.quantity).to eq 10
	end

	it 'quantity minus one' do
		product.one_less
		expect(product.quantity).to eq 9
	end
end
require 'coins'

describe Coins do
	let(:coins) { Coins.new 5, 5, 5, 5, 5, 5, 2, 2}

	it 'quantities' do
		expect(coins.one_p).to eq 5
		expect(coins.two_p).to eq 5
		expect(coins.five_p).to eq 5
		expect(coins.ten_p).to eq 5
		expect(coins.twenty_p).to eq 5
		expect(coins.fifty_p).to eq 5
		expect(coins.one_pound).to eq 2
		expect(coins.two_pounds).to eq 2
	end

	it 'denomination have values' do
		expect(coins.values["1p"]).to eq 1
		expect(coins.values["2p"]).to eq 2
		expect(coins.values["5p"]).to eq 5
		expect(coins.values["10p"]).to eq 10
		expect(coins.values["20p"]).to eq 20
		expect(coins.values["50p"]).to eq 50
		expect(coins.values["£1"]).to eq 100
		expect(coins.values["£2"]).to eq 200
	end

	it 'can calculate the total amount' do
		expect(coins.total).to eq 1040
	end

	it 'can calculate the change' do
		expect(coins.change(1)).to eq [1]
		expect(coins.change(4)).to eq [2, 2]
		expect(coins.change(6)).to eq [5, 1]
		expect(coins.change(48)).to eq [20, 20, 5, 2, 1]
		expect(coins.change(142)).to eq [100, 20, 20, 2]
		expect(coins.change(286)).to eq [200, 50, 20, 10, 5, 1]
	end

	it 'when receive a payment the quantity of coins increases' do
		coins.receive("10p")
		expect(coins.ten_p).to eq 6
	end

	it 'quantity increases with different numbers' do
		coins.receive("75p")
		expect(coins.fifty_p).to eq 6
		expect(coins.twenty_p).to eq 6
		expect(coins.five_p).to eq 6
	end

	it 'when receive a payment the total increases' do
		coins.receive("50p")
		expect(coins.total).to eq 1090
	end

end
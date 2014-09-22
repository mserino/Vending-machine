require 'coins'

describe Coins do
	let(:coins) { Coins.new 5, 5, 5, 5, 5, 5, 2, 2}

	context 'quantities' do
		it 'has 5 one p' do
			expect(coins.one_p).to eq 5
		end

		it 'has 5 two p' do
			expect(coins.two_p).to eq 5
		end

		it 'has 5 five p' do
			expect(coins.five_p).to eq 5
		end

		it 'has 5 ten p' do
			expect(coins.ten_p).to eq 5
		end

		it 'has 5 twenty p' do
			expect(coins.twenty_p).to eq 5
		end

		it 'has 5 fifty p' do
			expect(coins.fifty_p).to eq 5
		end

		it 'has 2 one pound' do
			expect(coins.one_pound).to eq 2
		end

		it 'has 2 two pounds' do
			expect(coins.two_pounds).to eq 2
		end
	end

	context 'can calculate the change' do
		it '1 for 1' do
			expect(coins.change(1)).to eq [1]
		end

		it '2,2 for 4' do
			expect(coins.change(4)).to eq [2, 2]
		end

		it '5,1 for 6' do
			expect(coins.change(6)).to eq [5, 1]
		end

		it '20,20,5,2,1 for 48' do
			expect(coins.change(48)).to eq [20, 20, 5, 2, 1]
		end

		it '100,20,20,2 for 142' do
			expect(coins.change(142)).to eq [100, 20, 20, 2]
		end

		it '200,50,20,10,5,1 for 286' do
			expect(coins.change(286)).to eq [200, 50, 20, 10, 5, 1]
		end
	end

	it 'can calculate the total amount' do
		expect(coins.total).to eq 1040
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
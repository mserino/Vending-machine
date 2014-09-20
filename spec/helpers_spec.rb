require './lib/helpers.rb'

class Helper; include Helpers; end

describe Helpers do

	context 'Converting change' do
	let(:helper) { Helper.new }

		it 'can convert price to denomination p' do
			expect(helper.convert(20)).to eq "20p"
		end

		it 'can convert price to denomination £' do
			expect(helper.convert(100)).to eq "£1"
		end

		it 'can convert denomination p to price' do
			expect(helper.convert("20p")).to eq 20
		end

		it 'can convert denomination £ to price' do
			expect(helper.convert("£1")).to eq 100
		end
	end
end
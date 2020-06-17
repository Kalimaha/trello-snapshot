# frozen_string_literal: true

require 'rspec'
require 'trello/tools/calculator'

RSpec.describe Trello::Tools::Calculator do
  subject(:calculator) { Trello::Tools::Calculator }

  describe '#sum' do
    it 'sums two numbers' do
      expect(calculator.sum(2, 3)).to eq(5)
    end
  end

  describe '#divide' do
    it 'divides two numbers' do
      expect(calculator.divide(14, 8)).to eq(1.75)
    end

    context 'but when b is zero' do
      it 'throws an exception' do
        expect { calculator.divide(14, 0) }.to raise_error('Division by zero.')
      end
    end
  end
end

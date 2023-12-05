# frozen_string_literal: true

require_relative '../lib/console_interface'

def get_cart_value(string)
  string.split("\n").last(3).join("\n")
end

RSpec.describe ConsoleInterface do
  describe '#store' do
    it 'runs and quits the store' do
      output = StringIO.new
      input = StringIO.new("q\n")
      console_interface = ConsoleInterface.new(output:, input:)
      console_interface.run

      expect(output.string).to eq("==============================\nHello! Welcome to my store!\n\nOptions:\n  s) store\n  c) cart\n  q) quit\n==============================\n")
    end
  end

  describe '#test discounts' do
    it 'applies green tea discount' do
      output = StringIO.new
      input = StringIO.new
      allow(input).to receive(:gets).and_return('add GR1 2', 'q')
      console_interface = ConsoleInterface.new(input:, output:)
      console_interface.run
      expect(get_cart_value(output.string)).to eq("==============================\n| Basket | Total price expected |\n| GR1,GR1 | 3.11€ |\n==============================\n")
    end

    it 'applies the strawberry discount' do
      output = StringIO.new
      input = StringIO.new
      allow(input).to receive(:gets).and_return('add SR1 3', 'q')
      console_interface = ConsoleInterface.new(input:, output:)
      console_interface.run
      expect(get_cart_value(output.string)).to eq("==============================\n| Basket | Total price expected |\n| SR1,SR1,SR1 | 13.5€ |\n==============================\n")
    end

    it 'applies the coffee discount' do
      output = StringIO.new
      input = StringIO.new
      allow(input).to receive(:gets).and_return('add CF1 3', 'q')
      console_interface = ConsoleInterface.new(input:, output:)
      console_interface.run
      expect(get_cart_value(output.string)).to eq("==============================\n| Basket | Total price expected |\n| SR1,SR1,SR1 | 22.46€ |\n==============================\n")
    end
  end

  describe '#test data set' do
    it 'accepts the CEO order' do
      output = StringIO.new
      input = StringIO.new
      allow(input).to receive(:gets).and_return('add GR1 2', 'q')
      console_interface = ConsoleInterface.new(input:, output:)
      console_interface.run
      expect(get_cart_value(output.string)).to eq("==============================\n| Basket | Total price expected |\n| GR1,GR1 | 3.11€ |\n==============================\n")
    end

    it 'accepts the COO order' do
      output = StringIO.new
      input = StringIO.new
      allow(input).to receive(:gets).and_return('add GR1 1', 'add SR1 3', 'q')
      console_interface = ConsoleInterface.new(input:, output:)
      console_interface.run
      expect(get_cart_value(output.string)).to eq("==============================\n| Basket | Total price expected |\n| SR1,SR1,SR1,GR1 |  16.61€ |\n==============================\n")
    end

    it 'accepts the VP of Engineering order' do
      output = StringIO.new
      input = StringIO.new
      allow(input).to receive(:gets).and_return('add GR1 1', 'add CF1 3', 'add SR1 1', 'q')
      console_interface = ConsoleInterface.new(input:, output:)
      console_interface.run
      expect(get_cart_value(output.string)).to eq("==============================\n| Basket | Total price expected |\n| GR1,CF1,CF1,CF1,SR1 | 30.57€ |\n==============================\n")
    end
  end
end

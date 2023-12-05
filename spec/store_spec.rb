# frozen_string_literal: true

require_relative '../lib/console_interface'

def get_cart_value(string)
  string.split("\n")[-2]
end

RSpec.describe ConsoleInterface do
  let(:output) { StringIO.new }
  let(:input) { StringIO.new }
  let(:subject) { ConsoleInterface.new(input:, output:) }
  let(:output_result) { get_cart_value(output.string) }

  describe '#store' do
    it 'runs and quits the store' do
      allow(input).to receive(:gets).and_return('q')
      subject.run

      expect(output.string.split("\n")[1..-2].join("\n")).to eq("Hello! Welcome to my store!\n\nOptions:\n  s) store\n  c) cart\n  q) quit")
    end
  end

  describe '#invalid inputs' do
    it 'only allows positive quantity values' do
      allow(input).to receive(:gets).and_return('q')
      subject.run

      expect(output.string.split("\n")[1..-2].join("\n")).to eq("Hello! Welcome to my store!\n\nOptions:\n  s) store\n  c) cart\n  q) quit")
    end
  end

  describe '#test discounts' do
    it 'does not apply green tea discount' do
      allow(input).to receive(:gets).and_return('add GR1 1', 'q')
      subject.run

      expect(output_result).to eq('| GR1 | 3.11€ |')
    end

    it 'applies green tea discount' do
      allow(input).to receive(:gets).and_return('add GR1 2', 'q')
      subject.run

      expect(output_result).to eq('| GR1,GR1 | 3.11€ |')
    end

    it 'applies green tea discount' do
      allow(input).to receive(:gets).and_return('add GR1 3', 'q')
      subject.run

      expect(output_result).to eq('| GR1,GR1,GR1 | 6.22€ |')
    end

    it 'applies the strawberry discount' do
      allow(input).to receive(:gets).and_return('add SR1 2', 'q')
      subject.run

      expect(output_result).to eq('| SR1,SR1 | 10.0€ |')
    end

    it 'applies the strawberry discount' do
      allow(input).to receive(:gets).and_return('add SR1 3', 'q')
      subject.run

      expect(output_result).to eq('| SR1,SR1,SR1 | 13.5€ |')
    end

    it 'does not apply the coffee discount' do
      allow(input).to receive(:gets).and_return('add CF1 2', 'q')
      subject.run

      expect(output_result).to eq('| CF1,CF1 | 22.46€ |')
    end

    it 'applies the coffee discount' do
      allow(input).to receive(:gets).and_return('add CF1 3', 'q')
      subject.run

      expect(output_result).to eq('| CF1,CF1,CF1 | 22.46€ |')
    end
  end

  describe '#test data set' do
    it 'accepts the CEO order' do
      allow(input).to receive(:gets).and_return('add GR1 2', 'q')
      subject.run

      expect(output_result).to eq('| GR1,GR1 | 3.11€ |')
    end

    it 'accepts the COO order' do
      allow(input).to receive(:gets).and_return('add SR1 3', 'add GR1 1', 'q')
      subject.run

      expect(output_result).to eq('| SR1,SR1,SR1,GR1 | 16.61€ |')
    end

    it 'accepts the VP of Engineering order' do
      allow(input).to receive(:gets).and_return('add GR1 1', 'add CF1 3', 'add SR1 1', 'q')
      subject.run

      expect(output_result).to eq('| GR1,CF1,CF1,CF1,SR1 | 30.57€ |')
    end
  end
end

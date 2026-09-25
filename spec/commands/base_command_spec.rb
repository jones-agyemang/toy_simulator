# frozen_string_literal: true

require_relative '../../lib/commands/base'

RSpec.describe BaseCommand do
  describe '.new' do
    it 'prevents direct instantiation' do
      expect do
        described_class.new(double, double)
      end.to raise_error(AbstractClassError, 'cannot be called directly')
    end
  end

  describe '.call' do
    it 'prevents direct invocation' do
      expect do
        described_class.call(double, double)
      end.to raise_error(AbstractClassError, 'cannot be called directly')
    end

    context 'when invoked on a subclass' do
      let(:robot) { double }
      let(:args) { double }
      let(:command_class) do
        Class.new(described_class) do
          def call = [robot, args]
        end
      end

      it 'initializes and invokes the command' do
        expect(command_class.call(robot, args)).to eq([robot, args])
      end
    end
  end

  describe '.produces_output?' do
    let(:dummy_command_class) { Class.new(described_class) }

    it 'defaults to false for subclasses' do
      expect(dummy_command_class).not_to be_produces_output
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/simulator'

RSpec.describe Simulator do
  describe '#run' do
    context 'when command set has no valid PLACE command' do
      it 'discards all commands' do
        commands = %w[MOVE REPORT]
        robot = spy('robot')
        simulator = described_class.new(commands, robot)
        simulator.run

        expect(robot).not_to have_received(:move)
      end
    end
  end
end

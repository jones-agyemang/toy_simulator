# frozen_string_literal: true

require_relative '../lib/simulator'

RSpec.describe Simulator do
  subject(:simulator) { described_class.new(commands, robot) }

  describe '#run' do
    context 'when command set has no valid PLACE command' do
      let(:commands) { %w[MOVE REPORT] }
      let(:robot) { spy('robot') }

      it 'discards all commands' do
        simulator.run

        expect(robot).not_to have_received(:move)
        expect(robot).not_to have_received(:report)
      end
    end

    context 'when command has a valid PLACE command' do
      context 'when PLACE at the beginning of the command sequence' do
        let(:commands) do
          [
            'PLACE 0,0,NORTH',
            'MOVE',
            'REPORT'
          ]
        end
        let(:robot) { Robot.new }

        it 'successfully executes all subsequent commands' do
          simulation_output = simulator.run

          expect(simulation_output).to eq(['0,1,NORTH'])
        end
      end
    end
  end
end

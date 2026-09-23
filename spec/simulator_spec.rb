# frozen_string_literal: true

require_relative '../lib/robot'
require_relative '../lib/simulator'

RSpec.describe Simulator do
  subject(:simulator) { described_class.new(commands, robot) }

  let(:robot) { Robot.new }

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
      context 'when PLACE command is at the beginning of the command sequence' do
        let(:commands) do
          [
            'PLACE 0,0,NORTH',
            'MOVE',
            'REPORT'
          ]
        end

        it 'successfully executes all subsequent commands' do
          simulation_output = simulator.run

          expect(simulation_output).to eq(['0,1,NORTH'])
        end
      end
    end

    context 'when PLACE command is within the command sequence' do
      let(:commands) do
        [
          'LEFT',
          'MOVE',
          'REPORT',
          'PLACE 0,0,NORTH',
          'LEFT',
          'REPORT'
        ]
      end

      it 'only executes all subsequent commands after placing the robot' do
        simulation_output = simulator.run

        expect(simulation_output).to eq(['0,0,WEST'])
      end
    end

    describe 'complex scenario' do
      let(:commands) do
        [
          'PLACE 1,2,EAST',
          'MOVE',
          'MOVE',
          'LEFT',
          'MOVE',
          'REPORT'
        ]
      end

      it 'successfully executes commands' do
        simulation_output = simulator.run
        expected_simulation_output = ['3,3,NORTH']

        expect(simulation_output).to eq(expected_simulation_output)
      end
    end
  end
end

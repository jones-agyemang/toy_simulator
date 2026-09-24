# frozen_string_literal: true

require_relative '../lib/robot'
require_relative '../lib/simulator'

RSpec.describe Simulator do
  subject(:simulator) { described_class.new(commands, robot) }

  let(:robot) { Robot.new }

  before { simulator.run }

  describe '#run' do
    context 'with invalid commands' do
      context 'when command not in valid command set' do
        let(:commands) do
          [
            'PLACE 0,0,NORTH',
            'FLY',
            'FIGHT',
            'REPORT'
          ]
        end

        it 'executes valid commands and ignores invalid ones' do
          expect(simulator.output).to eq(['0,0,NORTH'])
        end
      end

      context 'when command in valid command set' do
        context 'when malford' do
          let(:commands) do
            [
              'PLACE 0,0,NORTH',
              'PLACE',
              'MOVE',
              'MOVE OVER',
              'REPORT'
            ]
          end

          it 'ignores malformed commands' do
            expect(simulator.output).to eq(['0,1,NORTH'])
          end
        end
      end
    end

    context 'when command set has no valid PLACE command' do
      let(:commands) { %w[MOVE LEFT RIGHT REPORT] }

      it 'leaves the robot unplaced' do
        expect(robot).not_to be_placed
      end

      it 'produces no output' do
        expect(simulator.output).to eq([])
      end

      it 'does not change the position of the robot' do
        expect { simulator.run }.not_to change(robot, :position)
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
          expect(simulator.output).to eq(['0,1,NORTH'])
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
        expect(simulator.output).to eq(['0,0,WEST'])
      end
    end

    context 'when RIGHT follows a valid PLACE command' do
      let(:commands) do
        [
          'PLACE 0,0,NORTH',
          'RIGHT',
          'REPORT'
        ]
      end

      it 'rotates the robot to the right' do
        expect(simulator.output).to eq(['0,0,EAST'])
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
        expect(simulator.output).to eq(['3,3,NORTH'])
      end
    end
  end
end

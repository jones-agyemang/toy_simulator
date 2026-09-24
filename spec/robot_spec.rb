# frozen_string_literal: true

require 'rspec-parameterized'
require_relative '../lib/robot'

RSpec.describe Robot do
  subject(:robot) { described_class.new(table) }

  let(:width) { 5 }
  let(:height) { 5 }
  let(:table) { Table.new(width, height) }

  describe '#place' do
    context 'when initially placed' do
      context 'when outside the confines of the table' do
        let(:width) { 3 }

        it 'ignores placing the robot' do
          robot.place(x: 5, y: 5, orientation: 'NORTH')

          expect(robot.position).to eq({ x: nil, y: nil, orientation: nil })
        end
      end

      context 'when within the confines of the table' do
        it 'positions it on the table' do
          robot.place(x: 0, y: 0, orientation: 'NORTH')

          expect(robot.position).to eq({ x: 0, y: 0, orientation: 'NORTH' })
        end
      end

      context 'with invalid orientation' do
        it 'does not position it on the table' do
          expect do
            robot.place(x: 0, y: 0, orientation: 'ICEBERG')
          end.not_to change(robot, :position)
        end
      end
    end
  end

  describe '#report' do
    context 'when robot is unplaced' do
      it 'has nothing to report' do
        expect(robot.report).to be_nil
      end
    end

    context 'when robot is placed' do
      it 'reports current position' do
        robot.place(x: 0, y: 0, orientation: 'NORTH')

        expect(robot.report).to eq('0,0,NORTH')
      end
    end
  end

  describe '#move' do
    context 'when moving out of bounds' do
      where(:initial_x, :initial_y, :initial_orientation) do
        [
          [0, 0, 'SOUTH'],
          [4, 4, 'NORTH'],
          [0, 0, 'WEST'],
          [4, 4, 'EAST']
        ]
      end

      with_them do
        it 'prohibits movement' do
          starting_position = { x: initial_x, y: initial_y, orientation: initial_orientation }

          robot.place(**starting_position)
          robot.move

          expect(robot.position).to eq(starting_position)
        end
      end
    end

    context 'when moving within boundary' do
      where(:facing, :expected_x, :expected_y) do
        [
          ['NORTH', 2, 3],
          ['SOUTH', 2, 1],
          ['EAST', 3, 2],
          ['WEST', 1, 2]
        ]
      end
      let(:starting_position) { { x: 2, y: 2, orientation: facing } }

      with_them do
        it 'moves one unit in direction of orientation' do
          robot.place(**starting_position)
          robot.move

          expect(robot.position).to eq({ x: expected_x, y: expected_y, orientation: facing })
        end
      end
    end
  end

  describe 'rotations' do
    let(:starting_position) { { x: 0, y: 0, orientation: } }

    describe '#left' do
      where(:initial_orientation, :final_orientation) do
        [
          %w[NORTH WEST],
          %w[WEST SOUTH],
          %w[SOUTH EAST],
          %w[EAST NORTH]
        ]
      end

      with_them do
        context 'when facing initial orientation' do
          let(:orientation) { initial_orientation }

          it 'alters orientation to final orientation' do
            robot.place(**starting_position)
            robot.left

            expect(robot.position).to eq({ x: 0, y: 0, orientation: final_orientation })
          end
        end
      end
    end

    describe '#right' do
      where(:initial_orientation, :final_orientation) do
        [
          %w[NORTH EAST],
          %w[EAST SOUTH],
          %w[SOUTH WEST],
          %w[WEST NORTH]
        ]
      end

      with_them do
        context 'when facing initial orientation' do
          let(:orientation) { initial_orientation }

          it 'alters orientation to final orientation' do
            robot.place(**starting_position)
            robot.right

            expect(robot.position).to eq({ x: 0, y: 0, orientation: final_orientation })
          end
        end
      end
    end
  end
end

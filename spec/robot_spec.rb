# frozen_string_literal: true

require 'pry'
require 'rspec-parameterized'
require_relative '../lib/robot'

RSpec.describe Robot do
  subject(:robot) { described_class.new }

  describe '#place' do
    context 'when initially placed' do
      context 'when outside the confines of the board' do
        it 'raises an invalid move error' do
          expect { robot.place(x: 5, y: 5, orientation: 'NORTH') }.to raise_error(InvalidMoveError)
        end
      end

      context 'when within the confines of the board' do
        it 'positions it on the board' do
          initial_placement = { x: 0, y: 0, orientation: 'NORTH' }
          robot.place(**initial_placement)

          expected_position = initial_placement

          expect(robot.position).to eq(expected_position)
        end
      end

      context 'with invalid orientation' do
        it 'raises an orientation error' do
          expect do
            robot.place(x: 0, y: 0, orientation: 'ICEBERG')
          end.to raise_error(InvalidOrientationError)
        end
      end
    end
  end

  describe '#report' do
    context 'when robot is unplaced' do
      it 'has nothing to report' do
        expect(robot.report).to eq('')
      end
    end

    # TODO: Add spec for when Robot is placed
  end

  describe '#move' do
    context 'when moving out of bounds' do
      it 'prohibits movement' do
        starting_position = { x: 0, y: 0, orientation: 'SOUTH' }

        robot.place(**starting_position)
        robot.move

        expect(robot.position).to eq({ x: 0, y: 0, orientation: 'SOUTH' })
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

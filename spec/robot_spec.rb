# frozen_string_literal: true

require 'pry'
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
        it 'positions it with the right orientation' do
          robot.place(x: 0, y: 0, orientation: 'NORTH')

          expect(robot.report).to eq('0,0,NORTH')
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
      it 'should have nothing to report' do
        expect(robot.report).to eq('')
      end
    end
  end

  describe '#move' do
    context 'when moving out of bounds' do
      it 'prohibits movement' do
        starting_position = { x: 0, y: 0, orientation: 'SOUTH' }

        robot.place(**starting_position)
        robot.move

        expect(robot.report).to eq('0,0,SOUTH')
      end
    end

    context 'when moving within boundary' do
      {
        'NORTH' => '2,3,NORTH',
        'SOUTH' => '2,1,SOUTH',
        'EAST' => '3,2,EAST',
        'WEST' => '1,2,WEST'
      }.each do |orientation, expected_position|
        context "when facing #{orientation}" do
          let(:orientation) { orientation }
          let(:starting_position) { { x: 2, y: 2, orientation: } }

          it "moves one unit in direction of orientation(#{orientation})" do
            robot.place(**starting_position)
            robot.move
            
            expect(robot.report).to eq(expected_position)
          end
        end
      end

      context 'when facing NORTH' do
        let(:orientation) { 'NORTH' }

        it 'moves one unit NORTH' do
          starting_position = { x: 0, y: 0, orientation: }

          robot.place(**starting_position)
          robot.move

          expect(robot.report).to eq('0,1,NORTH')
        end
      end
    end
  end

  describe 'rotations' do
    let(:starting_position) { { x: 0, y: 0, orientation: } }

    describe '#left' do
      context 'when facing NORTH' do
        let(:orientation) { 'NORTH' }

        it 'alters orientation to WEST' do
          robot.place(**starting_position)
          robot.left

          expect(robot.report).to eq('0,0,WEST')
        end
      end

      context 'when facing WEST' do
        let(:orientation) { 'WEST' }

        it 'alters orientation to SOUTH' do
          robot.place(**starting_position)
          robot.left

          expect(robot.report).to eq('0,0,SOUTH')
        end
      end

      context 'when facing SOUTH' do
        let(:orientation) { 'SOUTH' }

        it 'alters orientation to EAST' do
          robot.place(**starting_position)
          robot.left

          expect(robot.report).to eq('0,0,EAST')
        end
      end

      context 'when facing EAST' do
        let(:orientation) { 'EAST' }

        it 'alters orientation to NORTH' do
          robot.place(**starting_position)
          robot.left

          expect(robot.report).to eq('0,0,NORTH')
        end
      end
    end

    describe '#right' do
      context 'when facing NORTH' do
        let(:orientation) { 'NORTH' }

        it 'alters orientation to EAST' do
          robot.place(**starting_position)
          robot.right

          expect(robot.report).to eq('0,0,EAST')
        end
      end

      context 'when facing EAST' do
        let(:orientation) { 'EAST' }

        it 'alters orientation to SOUTH' do
          robot.place(**starting_position)
          robot.right

          expect(robot.report).to eq('0,0,SOUTH')
        end
      end

      context 'when facing SOUTH' do
        let(:orientation) { 'SOUTH' }

        it 'alters orientation to WEST' do
          robot.place(**starting_position)
          robot.right

          expect(robot.report).to eq('0,0,WEST')
        end
      end

      context 'when facing WEST' do
        let(:orientation) { 'WEST' }

        it 'alters orientation to NORTH' do
          robot.place(**starting_position)
          robot.right

          expect(robot.report).to eq('0,0,NORTH')
        end
      end
    end
  end
end

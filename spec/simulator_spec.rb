# frozen_string_literal: true

require 'pry'
require_relative '../lib/simulator'

RSpec.describe Simulator do
  subject(:toy) { described_class.new }

  describe '#place' do
    context 'when initially placed' do
      context 'when outside the confines of the board' do
        it 'raises an invalid move error' do
          expect { toy.place(x: 5, y: 5, orientation: 'NORTH') }.to raise_error(InvalidMoveError)
        end
      end

      context 'when within the confines of the board' do
        it 'positions it with the right orientation' do
          toy.place(x: 0, y: 0, orientation: 'NORTH')

          expect(toy.report).to eq('0,0,NORTH')
        end
      end

      context 'with invalid orientation' do
        it 'raises an orientation error' do
          expect do
            toy.place(x: 0, y: 0, orientation: 'ICEBERG')
          end.to raise_error(InvalidOrientationError)
        end
      end
    end
  end

  describe '#report' do
    context 'when toy is unplaced' do
      it 'should have nothing to report' do
        expect(toy.report).to eq('')
      end
    end
  end

  describe '#move' do
    context 'when moving out of bounds' do
      it 'prohibits movement' do
        starting_position = { x: 0, y: 0, orientation: 'SOUTH' }

        toy.place(**starting_position)
        toy.move

        expect(toy.report).to eq('0,0,SOUTH')
      end
    end

    context 'when moving within boundary' do
      it 'facilitates movement' do
        starting_position = { x: 0, y: 0, orientation: 'NORTH' }

        toy.place(**starting_position)
        toy.move

        expect(toy.report).to eq('0,1,NORTH')
      end
    end
  end

  describe 'rotations' do
    let(:starting_position) { { x: 0, y: 0, orientation: } }

    describe '#left' do
      context 'when facing NORTH' do
        let(:orientation) { 'NORTH' }

        it 'alters orientation to WEST' do
          toy.place(**starting_position)
          toy.left

          expect(toy.report).to eq('0,0,WEST')
        end
      end

      context 'when facing WEST' do
        let(:orientation) { 'WEST' }

        it 'alters orientation to SOUTH' do
          toy.place(**starting_position)
          toy.left

          expect(toy.report).to eq('0,0,SOUTH')
        end
      end

      context 'when facing SOUTH' do
        let(:orientation) { 'SOUTH' }

        it 'alters orientation to EAST' do
          toy.place(**starting_position)
          toy.left

          expect(toy.report).to eq('0,0,EAST')
        end
      end

      context 'when facing EAST' do
        let(:orientation) { 'EAST' }

        it 'alters orientation to NORTH' do
          toy.place(**starting_position)
          toy.left

          expect(toy.report).to eq('0,0,NORTH')
        end
      end
    end
  end
end

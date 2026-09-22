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

      context 'with invalid orientation' do
        it 'raises an orientation error' do
          expect do
            toy.place(x: 0, y: 0, orientation: 'ICEBERG')
          end.to raise_error(InvalidOrientationError)
        end
      end
    end
  end
end

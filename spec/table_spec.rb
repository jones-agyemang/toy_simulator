# frozen_string_literal: true

require_relative '../lib/table'

RSpec.describe Table do
  subject(:table) { described_class.new(width, height) }

  let(:width) { 5 }
  let(:height) { 5 }

  describe '#new' do
    it 'creates a table with default width of 5' do
      expect(table.width).to eq(5)
    end

    it 'creates a table with default height of 5' do
      expect(table.height).to eq(5)
    end
  end

  describe '#within_bounds?' do
    context 'with out of bounds dimensions' do
      let(:width) { 6 }
      let(:height) { 9 }

      it "returns 'false'" do
        expect(table.within_bounds?(7, 10)).to be(false)
      end
    end

    context 'with bounded dimensions' do
      let(:width) { 10 }
      let(:height) { 10 }

      it "returns 'false'" do
        expect(table.within_bounds?(9, 9)).to be(true)
      end
    end
  end
end

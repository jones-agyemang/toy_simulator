# frozen_string_literal: true

require_relative '../lib/table'

RSpec.describe Table do
  subject(:table) { described_class.new }

  describe '#new' do
    it 'creates a table with default width of 5' do
      expect(table.width).to eq(5)
    end

    it 'creates a table with default height of 5' do
      expect(table.height).to eq(5)
    end
  end
end

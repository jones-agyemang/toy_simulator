# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/move/west'

RSpec.describe Move::West do
  subject(:invoke_movement) { described_class.call(robot) }

  describe '.call' do
    let(:robot) { instance_double(Robot) }
    let(:table) { instance_double(Table) }

    before do
      allow(table).to receive(:within_bounds?).and_return(true)
      allow(robot).to receive_messages(table: table, x: 0, y: 0)
      allow(robot).to receive(:y=)
      allow(robot).to receive(:x=)

      invoke_movement
    end

    it 'moves robot to the left' do
      expect(robot).to have_received(:x=).with(-1)
    end

    it 'does not move robot to the right' do
      expect(robot).not_to have_received(:x=).with(1)
    end

    it 'does not move robot up' do
      expect(robot).not_to have_received(:y=).with(1)
    end

    it 'does not move robot down' do
      expect(robot).not_to have_received(:y=).with(-1)
    end
  end
end

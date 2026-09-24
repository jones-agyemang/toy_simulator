# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/move_command'

RSpec.describe MoveCommand do
  describe '.call' do
    it 'delegates movement to the robot' do
      robot = instance_spy(Robot)
      described_class.call(robot)

      expect(robot).to have_received(:move).once
    end
  end

  describe '.produces_report?' do
    it 'produces no output' do
      expect(described_class).not_to be_produces_output
    end
  end
end

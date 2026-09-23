# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/left_command'

RSpec.describe LeftCommand do
  describe '.call' do
    it 'delegates left rotation to the robot' do
      robot = instance_spy(Robot)
      described_class.call(robot)

      expect(robot).to have_received(:left).once
    end
  end
end

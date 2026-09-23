# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/right_command'

RSpec.describe RightCommand do
  describe '.call' do
    it 'delegates right rotation to the robot' do
      robot = instance_spy(Robot)
      described_class.call(robot)

      expect(robot).to have_received(:right).once
    end
  end
end

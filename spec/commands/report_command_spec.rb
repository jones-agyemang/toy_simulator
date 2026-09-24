# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/report_command'

RSpec.describe ReportCommand do
  describe '.call' do
    it 'delegates reporting to the robot' do
      robot = instance_spy(Robot, report: '0,0,NORTH')

      described_class.call(robot)

      expect(robot).to have_received(:report).once
    end
  end
end

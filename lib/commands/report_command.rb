# frozen_string_literal: true

require_relative '../../lib/commands/base'

# Reports the robot's current position
class ReportCommand < BaseCommand
  def call
    robot.report
  end

  def self.produces_output? = true
end

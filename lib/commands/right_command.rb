# frozen_string_literal: true

require_relative '../../lib/commands/base'

# Rotates robot to the right
class RightCommand < BaseCommand
  def call
    robot.right
  end
end

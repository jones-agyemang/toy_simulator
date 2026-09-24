# frozen_string_literal: true

require_relative '../../lib/commands/base'

# Rotates robot to the left
class LeftCommand < BaseCommand
  def call
    robot.left unless args
  end
end

# frozen_string_literal: true

require_relative '../../lib/commands/base'

# Moves robot in direction of orientation
class MoveCommand < BaseCommand
  def call
    robot.move unless args
  end
end

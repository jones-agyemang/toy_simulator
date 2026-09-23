# frozen_string_literal: true

require_relative '../../lib/commands/base'

# Moves robot in direction of orientation
class MoveCommand < BaseCommand
  attr_reader :robot

  def call
    robot.move
  end
end

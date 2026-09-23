# frozen_string_literal: true

# Moves robot in direction of orientation
class MoveCommand
  attr_reader :robot

  def initialize(robot)
    @robot = robot
  end

  def self.call(robot)
    new(robot).call
  end

  def call
    robot.move
  end
end

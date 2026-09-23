# frozen_string_literal: true

module Move
  # Moves one unit to the East
  class East
    attr_accessor :robot

    def initialize(robot)
      @robot = robot
    end

    def self.call(robot)
      return unless robot.table.within_bounds?(robot.x + 1, robot.y)

      new(robot)
      robot.x += 1
    end
  end
end

# frozen_string_literal: true

module Move
  # Moves one unit to the North
  class South
    attr_accessor :robot

    def initialize(robot)
      @robot = robot
    end

    def self.call(robot)
      return unless robot.table.within_bounds?(robot.x, robot.y - 1)

      new(robot)
      robot.y -= 1
    end
  end
end

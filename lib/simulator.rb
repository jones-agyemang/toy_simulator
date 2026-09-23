# frozen_string_literal: true

require_relative '../lib/commands/place_command'
require_relative '../lib/commands/move_command'
require_relative '../lib/commands/left_command'
require_relative '../lib/commands/right_command'

# Runs the given
class Simulator
  attr_reader :commands, :robot

  def initialize(commands, robot)
    @commands = commands
    @robot = robot
  end

  def run
    output = []

    commands.each do |command|
      cmd, args = command.split

      case cmd
      when 'PLACE' then PlaceCommand.call(robot, args)
      when 'MOVE'
        next unless robot.placed?

        MoveCommand.call(robot)
      when 'LEFT'
        next unless robot.placed?

        LeftCommand.call(robot)
      when 'RIGHT'
        next unless robot.placed?

        RightCommand.call(robot)
      when 'REPORT'
        next unless robot.placed?

        output << robot.report
      end
    end

    output
  end
end

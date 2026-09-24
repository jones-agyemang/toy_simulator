# frozen_string_literal: true

require_relative '../lib/commands/place_command'
require_relative '../lib/commands/move_command'
require_relative '../lib/commands/left_command'
require_relative '../lib/commands/right_command'

# Runs the given
class Simulator
  attr_reader :commands, :robot, :output

  def initialize(commands, robot)
    @commands = commands
    @robot = robot
    @output = []
  end

  def run
    commands.each do |command|
      cmd, args = command.split

      case cmd
      when 'PLACE' then PlaceCommand.call(robot, args)
      when 'MOVE' then MoveCommand.call(robot)
      when 'LEFT' then LeftCommand.call(robot)
      when 'RIGHT' then RightCommand.call(robot)
      when 'REPORT'
        report = ReportCommand.call(robot)
        output << report unless report.nil?
      end
    end
    output
  end
end

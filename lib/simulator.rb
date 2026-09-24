# frozen_string_literal: true

require_relative 'commands/place_command'
require_relative 'commands/move_command'
require_relative 'commands/left_command'
require_relative 'commands/right_command'
require_relative 'commands/report_command'

# Runs the given
class Simulator
  attr_reader :commands, :robot, :output

  def initialize(commands, robot)
    @commands = commands
    @robot = robot
    @output = []
  end

  COMMAND_MAP = {
    'PLACE' => PlaceCommand,
    'MOVE' => MoveCommand,
    'LEFT' => LeftCommand,
    'RIGHT' => RightCommand,
    'REPORT' => ReportCommand
  }.freeze

  def run
    commands.each do |command|
      cmd, args = command.split
      cmd_class = COMMAND_MAP[cmd]

      next unless cmd_class

      result = cmd_class.call(robot, args)
      @output << result if cmd == 'REPORT' && result
    end
  end
end

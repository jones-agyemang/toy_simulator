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

      begin
        result = COMMAND_MAP.fetch(cmd)&.call(robot, args)
        output << result unless result.nil?
      rescue KeyError
        # no-op
      end
    end
    output
  end
end

# frozen_string_literal: true

# Runs the given
class Simulator
  attr_reader :commands, :robot

  def initialize(commands, robot)
    @commands = commands
    @robot = robot
  end

  def run
    placed = false
    output = []
    commands.each do |command|
      cmd, args = command.split(' ')

      placed = true if cmd == 'PLACE'
      next unless placed

      case cmd
      when 'PLACE'
        x, y, orientation = args.split(',')
        robot.place(x: x.to_i, y: y.to_i, orientation: )
      when 'MOVE'
        robot.move
      when 'REPORT'
        output << robot.report
      end
    end

    output
  end
end

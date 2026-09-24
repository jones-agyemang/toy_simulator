# frozen_string_literal: true

require_relative 'base'

# Executes PLACE command
class PlaceCommand < BaseCommand
  VALID_ORIENTATIONS = %w[NORTH SOUTH EAST WEST].freeze

  def initialize(robot, args)
    super
    @args = build_args(args)
  end

  def call
    return unless valid_args?

    x, y, orientation = args
    robot.place(x: x.to_i, y: y.to_i, orientation:)
  end

  private

  def build_args(arg_value)
    arg_value.split(',')
  end

  def valid_args?
    valid_numbers? && valid_arg_count? && valid_orientation?
  end

  def valid_numbers?
    args[0..1].all? { |value| Integer(value) >= 0 }
  rescue ArgumentError
    false
  end

  def valid_arg_count?
    args.count == 3
  end

  def valid_orientation?
    VALID_ORIENTATIONS.include?(args[2])
  end
end

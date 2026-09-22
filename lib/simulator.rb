# frozen_string_literal: true

class InvalidMoveError < StandardError; end
class InvalidOrientationError < StandardError; end

# Simulates toy robot interactions
class Simulator
  VALID_ORIENTATIONS = %w[NORTH SOUTH EAST WEST].freeze

  attr_reader :board
  attr_accessor :position

  def initialize
    @board = [5, 5]
    @position = { x: nil, y: nil, orientation: nil }
  end

  # rubocop:disable Naming/MethodParameterName
  def place(x:, y:, orientation:)
    raise InvalidMoveError unless within_bounds?(x, 0) || within_bounds?(y, 1)
    raise InvalidOrientationError unless VALID_ORIENTATIONS.include?(orientation)

    position[:x] = x
    position[:y] = y
    position[:orientation] = orientation
  end
  # rubocop:enable Naming/MethodParameterName

  def report
    return '' if position.values.any?(&:nil?)

    [position[:x], position[:y], position[:orientation]].join(',')
  end

  private

  def within_bounds?(position, axis)
    position.negative? || position < (@board[axis] - 1)
  end
end

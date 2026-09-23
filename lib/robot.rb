# frozen_string_literal: true

require_relative '../lib/errors/invalid_move_error'
require_relative '../lib/errors/invalid_orientation_error'

# Bot that facilitates exploration
class Robot
  VALID_ORIENTATIONS = %w[NORTH SOUTH EAST WEST].freeze
  ORIENTATION_MAPPING = {
    'NORTH' => 'WEST',
    'WEST' => 'SOUTH',
    'SOUTH' => 'EAST',
    'EAST' => 'NORTH'
  }.freeze

  attr_reader :board
  attr_accessor :position

  def initialize
    @board = [5, 5]
    @position = { x: nil, y: nil, orientation: nil }
  end

  # rubocop:disable-next Naming/MethodParameterName
  def place(x:, y:, orientation:)
    raise InvalidMoveError unless within_bounds?(x, 0) || within_bounds?(y, 1)
    raise InvalidOrientationError unless VALID_ORIENTATIONS.include?(orientation)

    position[:x] = x
    position[:y] = y
    position[:orientation] = orientation
  end

  def report
    return '' if position.values.any?(&:nil?)

    [position[:x], position[:y], position[:orientation]].join(',')
  end

  def move
    case position[:orientation]
    when 'NORTH'
      position[:y] += 1 if (position[:y] + 1).between?(0, board[1] - 1)
    when 'SOUTH'
      position[:y] -= 1 if (position[:y] - 1).between?(0, board[1] - 1)
    when 'EAST'
      position[:x] += 1 if (position[:x] + 1).between?(0, board[0] - 1)
    when 'WEST'
      position[:x] -= 1 if (position[:x] - 1).between?(0, board[0] - 1)
    end
  end

  def left
    position[:orientation] = ORIENTATION_MAPPING.fetch(position[:orientation])
  end

  def right
    position[:orientation] = ORIENTATION_MAPPING.invert.fetch(position[:orientation])
  end

  private

  def within_bounds?(position, axis)
    position.negative? || position < (@board[axis] - 1)
  end
end

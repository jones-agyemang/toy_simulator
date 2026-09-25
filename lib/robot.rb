# frozen_string_literal: true

require_relative '../lib/table'

# Bot that facilitates exploration
class Robot
  LEFT_TURNS = {
    'NORTH' => 'WEST',
    'WEST' => 'SOUTH',
    'SOUTH' => 'EAST',
    'EAST' => 'NORTH'
  }.freeze
  RIGHT_TURNS = LEFT_TURNS.invert.freeze
  VALID_ORIENTATIONS = LEFT_TURNS.keys.freeze

  MOVEMENT_MAPPING = {
    'NORTH' => [0, 1],
    'SOUTH' => [0, -1],
    'EAST' => [1, 0],
    'WEST' => [-1, 0]
  }.transform_values(&:freeze).freeze

  attr_reader :x, :y, :orientation, :placed, :table

  def initialize(table = Table.new)
    @table = table
    @x = nil
    @y = nil
    @orientation = nil
    @placed = false
  end

  # rubocop:disable-next Naming/MethodParameterName
  def place(x:, y:, orientation:)
    return unless table.within_bounds?(x, y) && VALID_ORIENTATIONS.include?(orientation)

    @placed = true
    @x = x
    @y = y
    @orientation = orientation
  end

  def placed? = placed

  def report
    [x, y, orientation].join(',') if placed?
  end

  def move
    return unless placed?

    x_delta, y_delta = MOVEMENT_MAPPING[orientation]
    x_next = x + x_delta
    y_next = y + y_delta

    return unless table.within_bounds?(x_next, y_next)

    @x = x_next
    @y = y_next
  end

  def left
    return unless placed?

    @orientation = LEFT_TURNS.fetch(orientation)
  end

  def right
    return unless placed?

    @orientation = RIGHT_TURNS.fetch(orientation)
  end

  def position
    { x:, y:, orientation: }
  end
end

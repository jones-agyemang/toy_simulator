# frozen_string_literal: true

require_relative '../lib/table'

# Bot that facilitates exploration
class Robot
  ORIENTATION_MAPPING = {
    'NORTH' => 'WEST',
    'WEST' => 'SOUTH',
    'SOUTH' => 'EAST',
    'EAST' => 'NORTH'
  }.freeze
  VALID_ORIENTATIONS = ORIENTATION_MAPPING.keys.freeze

  MOVEMENT_MAPPING = {
    'NORTH' => [0, 1],
    'SOUTH' => [0, -1],
    'EAST' => [1, 0],
    'WEST' => [-1, 0]
  }.freeze

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
    return unless table.within_bounds?(x, y)
    return unless VALID_ORIENTATIONS.include?(orientation)

    @placed = true
    @x = x
    @y = y
    @orientation = orientation
  end

  def placed? = placed

  def report
    return unless placed?

    [x, y, orientation].join(',')
  end

  def move
    return unless placed?

    x_axis, y_axis = MOVEMENT_MAPPING[orientation]

    return unless table.within_bounds?(@x + x_axis, @y + y_axis)

    @x += x_axis
    @y += y_axis
  end

  def left
    return unless placed?

    @orientation = ORIENTATION_MAPPING.fetch(@orientation)
  end

  def right
    return unless placed?

    @orientation = ORIENTATION_MAPPING.invert.fetch(@orientation)
  end

  def position
    { x: @x, y: @y, orientation: @orientation }
  end
end

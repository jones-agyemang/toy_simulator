# frozen_string_literal: true

require_relative '../lib/table'

# Bot that facilitates exploration
class Robot
  VALID_ORIENTATIONS = %w[NORTH SOUTH EAST WEST].freeze
  ORIENTATION_MAPPING = {
    'NORTH' => 'WEST',
    'WEST' => 'SOUTH',
    'SOUTH' => 'EAST',
    'EAST' => 'NORTH'
  }.freeze

  attr_reader :table

  def initialize
    @table = Table.new
  end

  # rubocop:disable-next Naming/MethodParameterName
  def place(x:, y:, orientation:)
    return unless table.within_bounds?(x, y)
    return unless VALID_ORIENTATIONS.include?(orientation)

    @x = x
    @y = y
    @orientation = orientation
  end

  def report
    return '' if position.values.any?(&:nil?)

    [@x, @y, @orientation].join(',')
  end

  def move
    case @orientation
    when 'NORTH'
      @y += 1 if table.within_bounds?(@x, @y + 1)
    when 'SOUTH'
      @y -= 1 if table.within_bounds?(@x, @y - 1)
    when 'EAST'
      @x += 1 if table.within_bounds?(@x + 1, @y)
    when 'WEST'
      @x -= 1 if table.within_bounds?(@x - 1, @y)
    end
  end

  def left
    @orientation = ORIENTATION_MAPPING.fetch(@orientation)
  end

  def right
    @orientation = ORIENTATION_MAPPING.invert.fetch(@orientation)
  end

  def position
    { x: @x, y: @y, orientation: @orientation }
  end
end

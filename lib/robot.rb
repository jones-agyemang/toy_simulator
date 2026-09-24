# frozen_string_literal: true

require_relative '../lib/table'
require_relative '../lib/move/north'
require_relative '../lib/move/south'
require_relative '../lib/move/east'
require_relative '../lib/move/west'

# Bot that facilitates exploration
class Robot
  ORIENTATION_MAPPING = {
    'NORTH' => 'WEST',
    'WEST' => 'SOUTH',
    'SOUTH' => 'EAST',
    'EAST' => 'NORTH'
  }.freeze
  VALID_ORIENTATIONS = ORIENTATION_MAPPING.keys.freeze

  attr_accessor :x, :y, :orientation, :placed
  attr_reader :table

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

    self.placed = true
    self.x = x
    self.y = y
    self.orientation = orientation
    nil
  end

  def placed? = placed

  def report
    return unless placed?

    [x, y, orientation].join(',')
  end

  def move
    case @orientation
    when 'NORTH' then Move::North.call(self)
    when 'SOUTH' then Move::South.call(self)
    when 'EAST' then Move::East.call(self)
    when 'WEST' then Move::West.call(self)
    end
    nil
  end

  def left
    return unless placed?

    @orientation = ORIENTATION_MAPPING.fetch(@orientation)
    nil
  end

  def right
    return unless placed?

    @orientation = ORIENTATION_MAPPING.invert.fetch(@orientation)
    nil
  end

  def position
    { x: @x, y: @y, orientation: @orientation }
  end
end

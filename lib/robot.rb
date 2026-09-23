# frozen_string_literal: true

require_relative '../lib/table'
require_relative '../lib/move/north'
require_relative '../lib/move/south'
require_relative '../lib/move/east'
require_relative '../lib/move/west'

# Bot that facilitates exploration
class Robot
  VALID_ORIENTATIONS = %w[NORTH SOUTH EAST WEST].freeze
  ORIENTATION_MAPPING = {
    'NORTH' => 'WEST',
    'WEST' => 'SOUTH',
    'SOUTH' => 'EAST',
    'EAST' => 'NORTH'
  }.freeze

  attr_accessor :x, :y, :orientation
  attr_reader :table

  def initialize(table = Table.new)
    @table = table
    @x = nil
    @y = nil
    @orientation = nil
  end

  # rubocop:disable-next Naming/MethodParameterName
  def place(x:, y:, orientation:)
    return unless table.within_bounds?(x, y)
    return unless VALID_ORIENTATIONS.include?(orientation)

    self.x = x
    self.y = y
    self.orientation = orientation
  end

  def report
    return '' if position.values.any?(&:nil?)

    [x, y, orientation].join(',')
  end

  def move
    case @orientation
    when 'NORTH' then Move::North.call(self)
    when 'SOUTH' then Move::South.call(self)
    when 'EAST' then Move::East.call(self)
    when 'WEST' then Move::West.call(self)
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

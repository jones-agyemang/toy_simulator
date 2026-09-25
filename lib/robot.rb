# frozen_string_literal: true

require 'pry'
require_relative '../lib/table'

# Bot that facilitates exploration
class Robot
  LEFT_TURNS = {
    north: :west,
    west: :south,
    south: :east,
    east: :north
  }.transform_values(&:freeze).freeze
  RIGHT_TURNS = LEFT_TURNS.invert.freeze
  VALID_ORIENTATIONS = LEFT_TURNS.keys.freeze

  MOVEMENT_MAPPING = {
    north: [0, 1],
    south: [0, -1],
    east: [1, 0],
    west: [-1, 0]
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
    x, y, orientation = build_args(x, y, orientation)

    return unless table.within_bounds?(x, y) && VALID_ORIENTATIONS.include?(orientation)

    @placed = true
    @x = x
    @y = y
    @orientation = orientation
  end

  def placed? = placed

  def report
    position.values.join(',') if placed?
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
    { x:, y:, orientation: orientation&.to_s&.upcase }
  end

  private

  def build_args(x, y, orientation)
    [Integer(x), Integer(y), orientation.downcase.to_sym]
  end
end

# frozen_string_literal: true

# Movement environment
class Table
  attr_reader :width, :height

  def initialize(width = 5, height = 5)
    @width = width
    @height = height
  end

  # rubocop:disable-next Naming/MethodParameterName
  def within_bounds?(x, y)
    x.between?(0, width - 1) && y.between?(0, height - 1)
  end
end

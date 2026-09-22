# frozen_string_literal: true

class InvalidMoveError < StandardError; end

# Simulates toy robot interactions
class Simulator
  attr_reader :board

  def initialize
    @board = [5, 5]
  end

  def place(x:, y:, orientation:)
    raise InvalidMoveError unless within_bounds?(x, 0) || within_bounds?(y, 1)
  end

  private

  def within_bounds?(position, axis)
    position.negative? || position < (@board[axis] - 1)
  end
end

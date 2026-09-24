# frozen_string_literal: true

# Base command class
class BaseCommand
  attr_reader :robot, :args

  def initialize(robot, args = nil)
    @robot = robot
    @args = args
  end

  def self.call(robot, args = nil)
    new(robot, args).call
  end

  def self.produces_output? = false
end

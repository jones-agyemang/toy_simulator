# frozen_string_literal: true

require_relative '../errors/abstract_class_error'

# Base command class
class BaseCommand
  attr_reader :robot, :args

  def initialize(robot, args = nil)
    raise AbstractClassError, 'cannot be called directly' if instance_of?(BaseCommand)

    @robot = robot
    @args = args
  end

  def self.call(robot, args = nil)
    new(robot, args).call
  end

  def self.produces_output? = false
end

# frozen_string_literal: true

# Base command class
class BaseCommand
  attr_reader :robot

  def initialize(robot)
    @robot = robot
  end

  def self.call(robot)
    new(robot).call
  end
end

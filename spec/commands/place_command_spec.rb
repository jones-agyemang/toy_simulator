# frozen_string_literal: true

require 'pry'
require 'rspec-parameterized'

require_relative '../../lib/robot'
require_relative '../../lib/commands/place_command'

RSpec.describe PlaceCommand do
  subject(:invoke_command!) { described_class.call(robot, args) }

  describe '.call' do
    let(:robot) { instance_spy(Robot) }

    context 'with malformed syntax' do
      where(:args) do
        [
          '0',
          '0,0',
          '0,0,',
          '0,0,nil',
          '0,0,0',
          '-1,0,NORTH',
          '0,-1,NORTH',
          'foo,bar,NORTH',
          '0.5,2,NORTH'
        ]
      end

      with_them do
        it 'does not execute command' do
          invoke_command!

          expect(robot).not_to have_received(:place)
        end
      end
    end
  end
end

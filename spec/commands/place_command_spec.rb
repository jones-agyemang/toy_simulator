# frozen_string_literal: true

require 'rspec-parameterized'

require_relative '../../lib/robot'
require_relative '../../lib/commands/place_command'

RSpec.describe PlaceCommand do
  subject(:invoke_command!) { described_class.call(robot, args) }

  describe '.call' do
    let(:robot) { instance_spy(Robot) }

    before { invoke_command! }

    context 'with no arguments' do
      let(:args) { nil }

      it 'ignores the command' do
        expect(robot).not_to have_received(:place)
      end
    end

    context 'with arguments' do
      context 'when argument syntax is malformed' do
        where(:args) do
          [
            nil,
            '',
            '0',
            '0,0',
            '0,0,',
            '-1,0,NORTH',
            '0,-1,NORTH',
            'foo,bar,NORTH',
            '0.5,2,NORTH'
          ]
        end

        with_them do
          it 'does not execute command' do
            expect(robot).not_to have_received(:place)
          end
        end
      end

      context 'when argument syntax is well-formed' do
        let(:args) { '0,1,NORTH' }

        it 'ignores the command' do
          expect(robot).to have_received(:place).with(x: 0, y: 1, orientation: 'NORTH')
        end
      end
    end
  end

  describe '.produces_output?' do
    it 'produces no output' do
      expect(described_class).not_to be_produces_output
    end
  end
end

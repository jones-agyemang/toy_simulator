# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/right_command'

RSpec.describe RightCommand do
  subject(:invoke_command!) { described_class.call(robot, args) }

  let(:robot) { instance_spy(Robot) }

  describe '.call' do
    before { invoke_command! }

    context 'with no arguments' do
      let(:args) { nil }

      it 'delegates right rotation to the robot' do
        expect(robot).to have_received(:right).once
      end
    end

    context 'with arguments' do
      let(:args) { 'foo' }

      it 'ignores the command' do
        expect(robot).not_to have_received(:right)
      end
    end
  end

  describe '.produces_report?' do
    it 'produces no output' do
      expect(described_class).not_to be_produces_output
    end
  end
end

# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/report_command'

RSpec.describe ReportCommand do
  subject(:invoke_command!) { described_class.call(robot, args) }

  let(:robot) { instance_spy(Robot, report: '0,0,NORTH') }

  describe '.call' do
    before { invoke_command! }

    context 'with no arguments' do
      let(:args) { nil }

      it 'delegates reporting to the robot' do
        expect(robot).to have_received(:report).once
      end
    end

    context 'with arguments' do
      let(:args) { 'foo' }

      it 'ignores the command' do
        expect(robot).not_to have_received(:report)
      end
    end
  end

  describe '.produces_report?' do
    it 'produces output' do
      expect(described_class).to be_produces_output
    end
  end
end

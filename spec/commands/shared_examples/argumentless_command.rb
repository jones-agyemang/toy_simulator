# frozen_string_literal: true

RSpec.shared_examples 'an argumentless command' do |robot_message|
  subject(:invoke_command!) { described_class.call(robot, args) }

  let(:robot) { instance_spy(Robot) }

  describe '.call' do
    before { invoke_command! }

    context 'with no arguments' do
      let(:args) { nil }

      it 'delegates the command to the robot' do
        expect(robot).to have_received(robot_message).once
      end
    end

    context 'with arguments' do
      let(:args) { 'foo' }

      it 'ignores the command' do
        expect(robot).not_to have_received(robot_message)
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/right_command'
require_relative 'shared_examples/argumentless_command'

RSpec.describe RightCommand do
  it_behaves_like 'an argumentless command', :right

  describe '.produces_report?' do
    it 'produces no output' do
      expect(described_class).not_to be_produces_output
    end
  end
end

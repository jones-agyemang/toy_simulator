# frozen_string_literal: true

require_relative '../../lib/robot'
require_relative '../../lib/commands/report_command'
require_relative 'shared_examples/argumentless_command'

RSpec.describe ReportCommand do
  it_behaves_like 'an argumentless command', :report

  describe '.produces_output?' do
    it 'produces output' do
      expect(described_class).to be_produces_output
    end
  end
end

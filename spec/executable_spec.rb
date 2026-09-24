# frozen_string_literal: true

require 'open3'

# rubocop:disable-next RSpec/DescribeClass
RSpec.describe 'Executable interface' do
  subject(:execute_simulation) { Open3.capture2(executable, options) }

  let(:executable) { File.expand_path('../bin/simulator', __dir__) }

  context 'with file-based commands' do
    let(:options) { File.expand_path('../fixtures/basic_movement.txt', __dir__) }

    it 'executes commands from file' do
      output, status = execute_simulation

      expect([output, status]).to match(["0,1,NORTH\n", be_success])
    end
  end

  context 'when commands are provided via standard input' do
    let(:commands) do
      <<~COMMANDS
        PLACE 1,2,EAST
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
        LEFT
        MOVE
        REPORT
      COMMANDS
    end
    let(:options) { { stdin_data: commands } }

    it 'executes commands from standard input' do
      output, status = execute_simulation

      expect([output, status]).to match(["3,3,NORTH\n2,3,WEST\n", be_success])
    end
  end
end

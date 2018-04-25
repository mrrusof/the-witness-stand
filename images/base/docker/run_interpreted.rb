#!/usr/bin/env ruby

require_relative 'run_harness'

class RunInterpreted < RunHarness

  def do_input_program
    input_json['interpretedProgram']
  end

  def do_write_command_input
    File.write program_path, input_program
  end

end

RunInterpreted.new.run

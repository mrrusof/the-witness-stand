#!/usr/bin/env ruby

require_relative 'run_harness'

class RunInterpreted < RunHarness

  def program
    input_json['interpretedProgram']
  end

  def write_program
    File.write program_path, program
  end

  def before_run_command
    write_program
  end

end

RunInterpreted.new.run

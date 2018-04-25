#!/usr/bin/env ruby

require_relative 'base_harness'
require 'json'

class RunHarness < BaseHarness

  def input_program
    do_input_program
  end

  def input_data
    input_json['input']
  end

  def do_validate_input_json
    abort 'No program given.' if !input_program
    abort 'No input data given.' if !input_data
  end

  def do_stdin_data
    input_data
  end

  def do_other_output_pairs
    {
      actualOutput: stdout
    }
  end

end

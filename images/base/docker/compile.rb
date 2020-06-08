#!/usr/bin/env ruby

require_relative 'base_harness'
require 'base64'

class CompileHarness < BaseHarness

  def source_path
    ENV['SRC']
  end

  def do_validate_other_env
    abort 'No source path given.' if !source_path
  end

  def input_source_program
    input_json['sourceProgram']
  end

  def do_validate_input_json
    abort 'No source given.' if !input_source_program
  end

  def do_write_command_input
    File.write source_path, input_source_program
  end

  def binary_program
    if File.exists? program_path
      Base64.strict_encode64 File.binread program_path
    else
      nil
    end
  end

  def do_other_output_pairs
    {
      stdout: stdout,
      binaryProgram: binary_program
    }
  end

end

CompileHarness.new.run

#!/usr/bin/env ruby

require_relative 'base_harness'
require 'base64'

class CompileHarness < BaseHarness

  def source_program_path
    ENV['SRC']
  end

  def compiled_program_path
    ENV['PRG']
  end

  def post_processing_command
    ENV['PST']
  end

  def do_validate_other_env
    abort 'No compiled program path given.' if !compiled_program_path
    abort 'No source program path given.' if !source_program_path
  end

  def source_program
    input_json['sourceProgram']
  end

  def do_validate_input_json
    abort 'No source program given.' if !source_program
  end

  def write_source_program
    File.write source_program_path, source_program
  end

  def do_before_run_command
    write_source_program
  end

  def maybe_post_process_compiled_program
    if post_processing_command && status.success?
      out = `#{post_processing_command}`
      if $? != 0
        abort "Post-processing command failed with code #{$?}:\n#{out}"
      end
    end
  end

  def do_after_run_command
    maybe_post_process_compiled_program
  end

  def compiled_program
    if File.exists? compiled_program_path
      Base64.strict_encode64 File.binread compiled_program_path
    else
      nil
    end
  end

  def do_other_output_pairs
    {
      compiledProgram: compiled_program
    }
  end

end

CompileHarness.new.run

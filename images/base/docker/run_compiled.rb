#!/usr/bin/env ruby

require_relative 'run_harness'
require 'base64'
require 'fileutils'

class RunCompiled < RunHarness

  def pre_processing_command
    ENV['PRE']
  end

  def do_program
    input_json['compiledProgram']
  end

  def write_compiled_program
    File.binwrite program_path, Base64.strict_decode64(program)
    FileUtils.chmod 0755, program_path
  end

  def maybe_pre_process_compiled_program
    if pre_processing_command
      out = `#{pre_processing_command}`
      if $? != 0
        abort "Pre-processing command failed with code #{$?}:\n#{out}"
      end
    end
  end

  def do_before_run_command
    write_compiled_program
    maybe_pre_process_compiled_program
  end

end

RunCompiled.new.run

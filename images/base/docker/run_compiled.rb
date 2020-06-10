#!/usr/bin/env ruby

require_relative 'run_harness'
require 'base64'
require 'fileutils'

class RunCompiled < RunHarness

  def do_program
    input_json['compiledProgram']
  end

  def write_program
    File.binwrite program_path, Base64.strict_decode64(program)
    FileUtils.chmod 0755, program_path
  end

  def do_before_run_command
    write_program
  end

end

RunCompiled.new.run

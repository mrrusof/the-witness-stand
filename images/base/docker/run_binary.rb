#!/usr/bin/env ruby

require_relative 'run_harness'
require 'base64'
require 'fileutils'

class RunBinary < RunHarness

  def do_input_program
    input_json['binaryProgram']
  end

  def do_write_command_input
    File.binwrite program_path, Base64.strict_decode64(input_program)
    FileUtils.chmod 0755, program_path
  end

end

RunBinary.new.run

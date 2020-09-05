#!/usr/bin/env ruby

require_relative 'base_harness'
require 'json'

class RunHarness < BaseHarness

  def program_path
    ENV['PRG']
  end

  def do_validate_other_env
    abort 'No program path given.' if !program_path
  end

  def program
    raise 'abstract RunHarness#program'
  end

  def stdin
    input_json['stdin']
  end

  def validate_input_json
    abort 'No program given.' if !program
    abort 'No stdin given.' if !stdin
  end

  def do_stdin
    stdin
  end

end

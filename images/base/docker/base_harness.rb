require 'json'
require 'open3'

class BaseHarness

  TIM = '/tmp/time'

  def program_path
    ENV['PRG']
  end

  def command
    ENV['CMD']
  end

  def do_validate_other_env
    # do nothing by default
  end

  def validate_env
    abort 'No program path given.' if !program_path
    abort 'No command given.' if !command
    do_validate_other_env
  end

  def input_json
    @input_json ||= JSON.parse ARGF.read
  end

  def validate_input_json
    do_validate_input_json
  end

  def write_command_input
    do_write_command_input
  end

  def do_stdin_data
    nil
  end

  def run_command
    @stdout, @stderr, @status = Open3.capture3 ENV, "time -o #{TIM} #{command}", stdin_data: do_stdin_data
    @time = nil
  end

  def stdout
    @stdout
  end

  def stderr
    @stderr
  end

  def status
    @status
  end

  def time
    @time ||= File.read(TIM).lines.select{|l| l.match? /real/ }.map{|l| l.gsub(/real\t/, '').chomp }.first
  end

  def base_output_pairs
    {
      stderr: stderr,
      exitCode: status.exitstatus,
      wallTime: time
    }
  end

  def do_other_output_pairs
    {}
  end

  def output_json
    base_output_pairs.merge do_other_output_pairs
  end

  def emit_output
    puts JSON.pretty_generate output_json
  end

  def run
    validate_env
    validate_input_json
    write_command_input
    run_command
    emit_output
  end

end

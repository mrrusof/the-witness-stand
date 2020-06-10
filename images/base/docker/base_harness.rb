require 'json'
require 'open3'

class BaseHarness

  def time_file_path
    '/tmp/time'
  end

  def command
    ENV['CMD']
  end

  def do_validate_other_env
    # do nothing by default
  end

  def validate_env
    abort 'No command given.' if !command
    do_validate_other_env
  end

  def input_json
    @input_json ||= JSON.parse ARGF.read
  end

  def validate_input_json
    do_validate_input_json
  end

  def before_run_command
    do_before_run_command
  end

  def do_stdin
    nil
  end

  def run_command
    @stdout, @stderr, @status = Open3.capture3 ENV, "time -o #{time_file_path} #{command}", stdin_data: do_stdin
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
    @time ||= File.read(time_file_path).lines.select{|l| l.match? /real/ }.map{|l| l.gsub(/real\t/, '').chomp }.first
  end

  def base_output_pairs
    {
      exitCode: status.exitstatus,
      stdout: stdout,
      stderr: stderr,
      wallTime: time
    }
  end

  def do_other_output_pairs
    {}
  end

  def output_json
    base_output_pairs.merge do_other_output_pairs
  end

  def emit_output_json
    puts JSON.pretty_generate output_json
  end

  def run
    validate_env
    validate_input_json
    before_run_command
    run_command
    emit_output_json
  end

end

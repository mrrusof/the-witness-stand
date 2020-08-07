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

  # virtual: do_validate_input_json

  def validate_input_json
    do_validate_input_json
  end

  # virtual: do_before_run_command

  def before_run_command
    do_before_run_command
  end

  def do_stdin
    nil
  end

  def run_command
    @stdout, @stderr, @status = Open3.capture3 ENV, "time -p -o #{time_file_path} #{command}", stdin_data: do_stdin
    @time = nil
  end

  def do_after_run_command
    # do nothing by default
  end

  def after_run_command
    do_after_run_command
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
    @time ||=
      begin
        raw_seconds, raw_decimals = File
                    .read(time_file_path)
                    .lines.select{|l| l.match? /real/ }
                    .map{|l| l.gsub(/real +/, '').chomp }
                    .first
                    .split('.')
                    .map(&:to_i)
        minutes = raw_seconds / 60
        seconds = raw_seconds % 60
        decimals = format '%02d', raw_decimals
        "#{minutes}m #{seconds}.#{decimals}s"
      end
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
    Thread.report_on_exception = false
    validate_env
    validate_input_json
    before_run_command
    run_command
    after_run_command
    emit_output_json
  end

end

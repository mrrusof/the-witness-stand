require 'json'
require 'open3'

class BaseHarness

  def time_file_path
    '/tmp/time'
  end

  def command
    ENV['CMD']
  end

  def validate_other_env
    # do nothing by default
  end

  def validate_env
    abort 'No command given.' if !command
    validate_other_env
  end

  def input_json
    @input_json ||= JSON.parse ARGF.read
  end

  def validate_input_json
    raise 'abstract BaseHarness#validate_input_json'
  end

  def before_run_command
    # do nothing by default
  end

  def stdin
    # do nothing by default
  end

  def run_command
    stdout_str = nil
    stderr_str = nil
    stdin_r, stdin_w = IO.pipe
    stdout_r, stdout_w = IO.pipe
    stderr_r, stderr_w = IO.pipe
    timed_command = "time -p -o #{time_file_path} #{command}"
    spawn_options = {
      :in => stdin_r,
      :out => stdout_w,
      :err => stderr_w
    }

    pid = spawn(ENV, timed_command, spawn_options)

    io_threads = [
      Thread.new {
        stdin_w.write stdin
        stdin_w.close
      },
      Thread.new {
        stdout_str = stdout_r.read
        stdout_r.close
      },
      Thread.new {
        stderr_str = stderr_r.read
        stderr_r.close
      }
    ]
    Process.wait pid
    stdin_r.close
    stdout_w.close
    stderr_w.close
    io_threads.each(&:join)
    @stdout = stdout_str
    @stderr = stderr_str
    @status = $?
    @time = nil
  end

  def after_run_command
    # do nothing by default
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

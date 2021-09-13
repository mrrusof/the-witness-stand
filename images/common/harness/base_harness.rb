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

  def input_fds_and_contents
    stdin_hash = if stdin then { 0 => stdin } else {} end
    (input_json['inputFds'] || {})
      .map { |k, v| [k.to_i, v] }
      .to_h
      .merge(stdin_hash)
  end

  def input_files_and_contents
    input_json['inputFiles'] || {}
  end

  def output_fds
    (input_json['outputFds'] || []) + [1, 2]
  end

  def output_files
    input_json['outputFiles'] || []
  end

  def validate_input_json
    raise 'abstract BaseHarness#validate_input_json'
  end

  def before_run_command
    # do nothing by default
  end

  def stdin
    input_json['stdin']
  end

  def run_command
    spawn_options = {}
    pipe_endpoints_to_close_after_command = []
    io_threads = []
    output_fds_contents = {}
    input_fds_and_contents.each { |fd, contents|
      r, w = IO.pipe
      spawn_options[fd] = r
      pipe_endpoints_to_close_after_command << r
      io_threads << Thread.new {
        begin
          w.write contents
        rescue Errno::EPIPE => e
        end
        w.close
      }
    }
    output_fds.each { |fd|
      r, w = IO.pipe
      spawn_options[fd] = w
      pipe_endpoints_to_close_after_command << w
      io_threads << Thread.new {
        read_something = false
        contents = ''
        begin
          while true
            contents.concat r.readpartial(4096)
            read_something = true
          end
        rescue EOFError => e
        end
        r.close
        output_fds_contents[fd] = if read_something then contents else nil end
      }
    }
    input_files_and_contents.each { |file, contents|
      File.write file, contents, mode: 'w'
    }
    timed_command = "time -p -o #{time_file_path} #{command}"

    pid = spawn(ENV, timed_command, spawn_options)

    Process.wait pid
    pipe_endpoints_to_close_after_command.each(&:close)
    io_threads.each(&:join)
    output_files_contents = output_files
                              .map { |file|
                                [file,
                                 if File.exist? file then
                                   File.read file
                                 end]
                              }
                              .to_h
    @stdout = output_fds_contents.delete(1)
    @stderr = output_fds_contents.delete(2)
    @output_fds_contents = output_fds_contents
    @output_files_contents = output_files_contents
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

  def output_fds_contents
    @output_fds_contents
  end

  def output_files_contents
    @output_files_contents
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
      outputFds: output_fds_contents,
      outputFiles: output_files_contents,
      wallTime: time
    }
  end

  def debug_output_pairs
    if ENV['TWS_DEBUG'] == 'true'
      {
        debug: {
          wallTimes: debug_wall_times
        }
      }
    else
      {}
    end
  end

  def other_output_pairs
    {}
  end

  def output_json
    base_output_pairs
      .merge(debug_output_pairs)
      .merge(other_output_pairs)
  end

  def emit_output_json
    puts JSON.pretty_generate output_json
  end

  def debug_wall_times
    @debug_wall_times ||= {}
  end

  def measure tag
    start_time = Time.now
    yield
    end_time = Time.now
    debug_wall_times[tag] = end_time - start_time
  end

  def run
    Thread.report_on_exception = false
    measure(:validate_env) { validate_env }
    measure(:validate_input_json) { validate_input_json }
    measure(:before_run_command) { before_run_command }
    measure(:run_command) { run_command }
    measure(:after_run_command) { after_run_command }
    emit_output_json
  end

end

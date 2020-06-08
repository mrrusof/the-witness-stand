#!/usr/bin/env ruby

require 'optparse'
require 'pathname'
require 'set'

class Inliner
  def initialize
    @inlined = Set.new
  end

  def inline path
    absolute_path = path_to_absolute_path(path, Dir.pwd)
    do_inline absolute_path
  end

  def deps path
    absolute_path = path_to_absolute_path(path, Dir.pwd)
    do_deps absolute_path
  end

  private

  def mark_inlined path
    @inlined << path
  end

  def inlined? path
    @inlined.member? path
  end

  def path_to_absolute_path ipath, pwd
    Pathname.new(pwd) + Pathname.new(ipath)
  end

  def inline_to_path str
    `echo #{str.gsub(/#inline +/, '')}`.chomp
  end

  def do_inline absolute_path
    mark_inlined absolute_path
    puts "# inlined #{absolute_path}"
    File.open(absolute_path) {|f|
      while not f.eof?
        l = f.readline
        if l.match? /#inline/
          pwd = File.dirname absolute_path
          inline_path = inline_to_path l
          absolute_inline_path = path_to_absolute_path(inline_path, pwd)
          unless inlined? absolute_inline_path
            do_inline absolute_inline_path
          end
        else
          print l
        end
      end
    }
  end

  def do_deps absolute_path
    mark_inlined absolute_path
    puts absolute_path
    File.open(absolute_path) {|f|
      while not f.eof?
        l = f.readline
        if l.match? /#inline/
          pwd = File.dirname absolute_path
          inline_path = inline_to_path l
          absolute_inline_path = path_to_absolute_path(inline_path, pwd)
          unless inlined? absolute_inline_path
            do_deps absolute_inline_path
          end
        end
      end
    }
  end
end

def main
  print_deps = false

  OptionParser.new { |opt|
    opt.on('--deps') {|_| print_deps = true }
  }.parse!

  inliner = Inliner.new

  if print_deps
    inliner.deps ARGV[0]
  else
    inliner.inline ARGV[0]
  end
end

main

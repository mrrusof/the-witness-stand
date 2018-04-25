#!/usr/bin/env ruby

require 'pathname'
require 'optparse'

def path_to_absolute_path ipath, pwd
  Pathname.new(pwd) + Pathname.new(ipath)
end

def inline_to_path str
  `echo #{str.gsub(/#inline +/, '')}`.chomp
end

def inline path
  puts "# inlined #{path}"
  File.open(path) {|f|
    while not f.eof?
      l = f.readline
      if l.match? /#inline/
        pwd = File.dirname path
        ipath = inline_to_path l
        inline path_to_absolute_path(ipath, pwd)
      else
        print l
      end
    end
  }
end

def deps path
  puts path
  File.open(path) {|f|
    while not f.eof?
      l = f.readline
      if l.match? /#inline/
        pwd = File.dirname path
        ipath = inline_to_path l
        deps path_to_absolute_path(ipath, pwd)
      end
    end
  }
end

def main
  print_deps = false

  OptionParser.new { |opt|
    opt.on('--deps') {|_| print_deps = true }
  }.parse!

  if print_deps
    deps path_to_absolute_path(ARGV[0], Dir.pwd)
  else
    inline ARGV[0]
  end
end

main

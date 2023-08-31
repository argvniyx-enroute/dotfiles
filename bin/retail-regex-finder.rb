#!/usr/bin/env ruby

require 'readline'

def is_dotfile?(filename)
  filename.start_with?(".")
end

def is_done_dir?(dirname)
  %w(
    @betterment
    advice_jl
    aggregation
    alchemrest
    auditor
    bd_ops_legacy
    broker-dealer
    broker_dealer_core
    checking
    doc
    doctor
    gm-retail
    gm-opsadmin
    gm-institutional
    loans
    node_modules
    ops-admin
    retaildb
    script
    securities
    shrink
    spinwheel
    tap
  ).include? dirname
end

def print_options(options)
  options.each.with_index { |d, i| puts "[#{i}] #{File.basename d}" }
  puts "[q] quit"
end

def rg_in_dir(dirname)
  regex = Readline.readline("regex> ")
  count_matches = Readline.readline("count matches? (y/n)> ")
  cmd = "rg #{regex} #{dirname} --ignore-file ~/spike-ignore.txt"
  cmd += " --count-matches" if count_matches == "y"
  system(cmd)
end

def grep_loop(dirs)
  begin
    print_options dirs

    while (input = Readline.readline("> ")) != "q"
      rg_in_dir(dirs[input.to_i]) if (0...dirs.count).include? Integer(input)
      puts
      print_options dirs
    end
  rescue ArgumentError
    puts "unknown option...\n\n"
    grep_loop(dirs)
  rescue Interrupt
    p "interrupted, exiting..."
    exit
  end
end

def main
  retail_path = "#{ENV['HOME']}/src/retail/"

  dirs = Dir.children(retail_path)
           .filter { |f| !is_dotfile? f }
           .sort
           .map { |f| retail_path + f }
           .filter { |f| FileTest.directory?(f) && !is_done_dir?(File.basename(f)) }

  grep_loop dirs
end

main

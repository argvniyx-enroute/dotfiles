#!/usr/bin/env ruby

require 'git'
require 'json'
require 'uri'

######################################################

def author
  @author ||= ARGV[0]
end

def repo
  @repo ||= ARGV[1]
end

def asana_urls(commit)
  URI.extract(commit.message).select { |uri| uri.match?("app.asana.com")}
end

def github_url(commit)
  pr_number = task_name(commit).match(/#\d+/).to_s[1..]

  "https://github.com/Betterment/#{repo}/pull/#{pr_number}"
end

def task_name(commit)
  commit.message.match(/.*\n\n/).to_s.strip
end

def task_entry(commit)
  {
    task_name: task_name(commit),
    asana_urls: asana_urls(commit),
    github_url: github_url(commit)
  }
end

def task_report
  Git.open("#{ENV['HOME']}/src/#{repo}")
    .branch("main")
    .gcommit
    .log
    .since("1 week ago")
    .author(author)
    .map { |c| task_entry(c) }
end

def usage
  'USAGE: week_tasks.rb "AUTHOR" (as shown by git log) REPO'
end

######################################################

puts(author && repo ? task_report.to_json : usage)

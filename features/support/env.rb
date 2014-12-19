# encoding: utf-8

require 'bundler/setup'
require 'forkforge'
require 'forkforge/knife/string'
require 'rspec/expectations'

MAX_SCENARIOS = 10
scenario_times = {}

Around() do |scenario, block|
  start = Time.now
  block.call
  scenario_times["#{scenario.feature.file}::#{scenario.name}"] = Time.now - start
end

at_exit do
  max_scenarios = scenario_times.size > MAX_SCENARIOS ? MAX_SCENARIOS : scenario_times.size
  puts '—'*20 + "  top #{max_scenarios} slowest  " + '—'*20
  sorted_times = scenario_times.sort { |a, b| b[1] <=> a[1] }
  sorted_times[0..max_scenarios - 1].each do |key, value|
    puts "#{value.round(2)}  #{key}"
  end
end

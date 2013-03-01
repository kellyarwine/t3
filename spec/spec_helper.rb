$:.unshift File.expand_path('../lib', __FILE__)

begin
  require 'simplecov'
  SimpleCov.start
rescue LoadError
  puts 'Coverage disabled, enable by installing simplecov'
end
 
require 'game_runner'
require 'game'
require 'game_rules'
require 'console_io'
require 'board'
require 'player'
require 'configurations'
require 'easy_ai'
require 'human'
require 'minimax'
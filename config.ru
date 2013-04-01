require 't3/ui_io'
require 't3/game_runner'
require 't3/player/human_strategy'
require 't3/player/minimax_strategy'
require 't3/player/easy_ai_strategy'
require 't3/board'
require 't3/io'
require 't3/router'

game_runner = T3::GameRunner.new

run T3::Router.new
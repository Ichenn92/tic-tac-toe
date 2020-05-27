require 'bundler/inline'

gemfile true do
 source 'http://rubygems.org'
 gem 'io-console'
end

require 'io/console'
require_relative 'game'
require_relative 'player'
require_relative 'color'

def clear_screen
  print `clear`
end

clear_screen

Game.new.play
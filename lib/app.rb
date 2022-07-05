# frozen_string_literal: true

require_relative 'game'
require_relative 'outputs'

def play_new_game
  game = Game.new
  game.play
  want_another_game
end

def want_another_game
  p 'Would you like to play again?'
  play_new_game if $stdin.gets.chomp.downcase == 'y'
  p 'Thank you for playing.'
end
play_new_game
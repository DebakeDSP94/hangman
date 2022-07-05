#frozen_string_literal: true

module Outputs

  def welcome
    puts "Welcome to Hangman"
  end

  def give_up
    puts "The secret word is #{word}"
  end
end
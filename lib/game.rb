# frozen_string_literal: true

require 'json'
require_relative 'outputs'

class Game
  include Outputs
  attr_accessor :word

  def initialize
    @word = ''
    @guess = ''
    @guessed_letters = []
    @wrong_guesses = []
    @guess_count = 10
  end

  def play
    select_word
    welcome
    give_up
  end

  def select_word
    possible_words = File.open('hangman_dictionary.txt', 'r'){ |file| file.read }
    possible_words_arr = possible_words.split("\n")
    @word = possible_words_arr.select { |word| word.length.between? 5, 12 }.sample.downcase
  end
end

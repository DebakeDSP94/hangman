# frozen_string_literal: true

require 'json'
require_relative 'outputs'
require_relative 'hangman'
require_relative 'save_load'

class Game
  include Outputs
  include Hangman
  include Save_load
  attr_accessor :word, :guess, :guessed_letters, :wrong_guesses, :correct_guesses, :guess_count

  def initialize
    @word = ''
    @word_arr = []
    @guess = ''
    @guessed_letters = []
    @wrong_guesses = []
    @correct_guesses = []
    @guess_count = 8
    @game_won = false
    @game_lost = false
    @saved = false
  end

  def play
    welcome
    instructions
    select_word
    @word.length.times do
      @correct_guesses << '_'
    end
    load_or_new
    hangman_case
    puts "   #{@correct_guesses.join('')}"
    play_turn
  end

  def play_turn
    prompt
    evaluate_guess
    hangman_case
    show_state if @game_won == false
    play_turn if @game_won == false && @game_lost == false && @saved == false
  end

  def evaluate_guess
    @word_arr.each_with_index do |ltr, index|
      @correct_guesses[index] = ltr if ltr == @guess
    end
    @wrong_guesses << @guess unless @word_arr.include?(@guess)
    @guess_count = (8 - @wrong_guesses.length)
    check_for_win
  end

  def check_for_win
    system("cls") || system("clear")
    @game_won = true if @word_arr == @correct_guesses
    @game_lost = true if @guess_count == 0
    win if @game_won
    lose if @game_lost
  end

  def select_word
    possible_words = File.open('hangman_dictionary.txt', 'r'){ |file| file.read }
    possible_words_arr = possible_words.split("\n")
    @word = possible_words_arr.select { |word| word.length.between? 5, 12 }.sample.downcase
    @word_arr = @word.split('')
  end

  def load_or_new
    prompt_load_or_new
    game_type = gets.chomp
    if game_type == '1'
      new_game
    elsif game_type =='2'
      load_game
      show_state
    else
      puts "Invalid input. Please try again"
      load_or_new
    end
  end

  def new_game
    puts "new game"
  end

  def prompt
    puts "Please enter a guess.  You have #{@guess_count} guesses remaining."
    player_input = gets.chomp.downcase 
    validated = validate_input(player_input)
    invalid_input if validated == 'invalid'
    process_input(player_input) if validated == 'valid'
  end

  def validate_input(player_input)
    return 'invalid' unless ('a'..'z').include?(player_input) || player_input == 'save' || player_input == 'giveup'

    'valid'
  end

  def process_input(player_input)
    if player_input == 'save'
      save_game
      @saved = true
    elsif player_input == 'giveup'
      give_up
    else
      @guess = player_input
      @guessed_letters << player_input unless @guessed_letters.include?(player_input)
    end
    if @wrong_guesses.include?(@guess)
      already_guessed unless player_input == 'save' || player_input == 'giveup'
      prompt unless player_input == 'save' || player_input == 'giveup'
    end
  end

  def invalid_input
    puts "That is not a valid letter.  Please try again"
    prompt
  end
end

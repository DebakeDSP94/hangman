# frozen_string_literal: true

require 'json'
require_relative 'outputs'

class Game
  include Outputs
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
  end

  def play
    welcome
    instructions
    select_word
    word.length.times do
      @correct_guesses << '_'
    end
    load_or_new
    play_turn
  end

  def play_turn
    prompt
    evaluate_guess
    show_state if @game_won == false && @game_lost == false
    play_turn if @game_won == false && @game_lost == false
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

  def load_game
    puts "load game: select a saved game to load"
    saved_games = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))]}
    puts saved_games
    filename = gets.chomp
    begin
      loaded = File.open("./saved/#{filename}.json", 'r') { |file| file.read }
    rescue
      puts "Incorrect file name"
      load_game
    end
    game_state = JSON.parse(loaded)
    @word = game_state.dig("word")
    @word_arr = game_state.dig("word_arr")
    @correct_guesses = game_state["correct"]
    @guessed_letters = game_state["guessed"]
    @wrong_guesses = game_state["wrong"]
    @guess_count = game_state["count"]
  end

  def prompt
    puts "Please enter a guess.  You have #{@guess_count} guesses remaining."
    player_input = gets.chomp
    if player_input.downcase == 'save'
      save_game
    elsif player_input.downcase == 'giveup'
      give_up
    else
      @guess = player_input
      @guessed_letters << player_input
    end
    if @wrong_guesses.include?(@guess)
    already_guessed unless player_input.downcase == 'save'
    prompt unless player_input.downcase == 'save'
    end
  end

  def save_game
    game_state = Hash.new
    game_state[:word] = @word
    game_state[:word_arr] = @word_arr
    game_state[:correct] = @correct_guesses
    game_state[:guessed] = @guessed_letters
    game_state[:wrong] = @wrong_guesses
    game_state[:count] = @guess_count
    puts "Choose a file name for your save game"
    save_name = gets.chomp
    File.open("./saved/#{save_name}.json", 'w') { |file| file.puts game_state.to_json}
    puts "game_saved"
  end

end

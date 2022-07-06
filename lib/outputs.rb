#frozen_string_literal: true

module Outputs

  def welcome
    puts "Welcome to Hangman"
    puts
  end

  def give_up
    puts "The secret word is #{word}"
  end

  def instructions
    puts 'The computer has randomly chosen a word between 5 and 12 characters long.'
    puts 'You will have to choose the letters that make up the word.  You are allowed'
    puts '8 incorrect guesses and then you will lose if you have not solved the secret word.'
    puts 'You may save the game at any time by typing "save".'
    puts
  end

  def prompt_load_or_new
    puts 'would you like to start a new game, or load a previous game?'
    puts '"1" for New Game'
    puts '"2" for Load Game'
  end

  def show_state
    puts "Guessed letters: #{@guessed_letters.join(',')}"
    puts "Wrong guesses:   #{@wrong_guesses.join(',')}"
    puts "Correct guesses: #{@correct_guesses.join('')}"
  end

  def win
    puts "You have solved the secret word '#{word}'"
    puts "you had a total of #{@wrong_guesses.length} wrong guesses"
  end

  def lose 
    puts "You have failed to guess the secret word '#{word}'"
  end

  def already_guessed
    puts "You have already guessed that letter.  Please try another letter."
  end
end
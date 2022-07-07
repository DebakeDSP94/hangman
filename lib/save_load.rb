# frozen_string_literal: true

module Save_load

  def load_game
    puts "load game: select a saved game to load."
    puts "Type in the name of one of the files listed below and hit Enter."
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
    @word = game_state["word"]
    @word_arr = game_state["word_arr"]
    @correct_guesses = game_state["correct"]
    @guessed_letters = game_state["guessed"]
    @wrong_guesses = game_state["wrong"]
    @guess_count = game_state["count"]
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
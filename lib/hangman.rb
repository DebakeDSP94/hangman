#frozen_string_literal: true

module Hangman

  def hangman_case
    case @guess_count
    when 8 then frame_1
    when 7 then frame_2
    when 6 then frame_3
    when 5 then frame_4
    when 4 then frame_5
    when 3 then frame_6
    when 2 then frame_7
    when 1 then frame_8
    when 0 then frame_9
    end
  end

  def frame_1
    puts "      ____"
    puts "     |   |"
    puts "         |"
    puts "         |"
    puts "         |"
    puts "   ______|"
  end

  def frame_2
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "         |"
    puts "         |"
    puts "   ______|"
  end

  def frame_3
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "     |   |"
    puts "         |"
    puts "   ______|"
  end

  def frame_4
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "    -|   |"
    puts "         |"
    puts "   ______|"
  end

  def frame_5
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "   --|   |"
    puts "         |"
    puts "   ______|"
  end

  def frame_6
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "   --|-  |"
    puts "         |"
    puts "   ______|"
  end

  def frame_7
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "   --|-- |"
    puts "         |"
    puts "   ______|"
  end

  def frame_8
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "   --|-- |"
    puts "    /    |"
    puts "   ______|"
  end

  def frame_9
    puts "      ____"
    puts "     |   |"
    puts "     o   |"
    puts "   --|-- |"
    puts "    / \\  |"
    puts "   ______|"
  end
end

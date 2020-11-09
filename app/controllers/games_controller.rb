class GamesController < ApplicationController
  def new
    @grid = []
    6.times do
      letter = ("A".."Z").to_a.sample
      @grid << letter
    end
    @@grid = @grid
  end

  def score
    @guess = params[:word].upcase
    if !english_word?(@guess)
      @score = "Sorry but #{@guess} does not seem to be a valid English word..."
    elsif !@guess.chars.all? { |letter| @guess.count(letter) <= @@grid.count(letter) }
      @score = "Sorry but #{@guess} can´t be built from #{@@grid.join(", ")}"
    else
      @score = "Congradulations! #{@guess} is a valid English word!"
    end
    return @score
  end

  private

  # def included?(guess, grid)
  #   guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  # end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  # def compute_score(attempt, time_taken)
  #   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  # end
end

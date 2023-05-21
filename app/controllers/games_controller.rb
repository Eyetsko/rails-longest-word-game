require 'open-uri'

class GamesController < ApplicationController
  def new
    array = ('a'..'z').to_a
    @letters = []
    @letters << array.sample(10).join(' ')
  end

  def score
    letters = params[:letters].split
    word = params[:word]
    api_url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionary_serialized = URI.open(api_url).read
    results = JSON.parse(dictionary_serialized)
    if word.chars.all? { |letter| word.count(letter) <= letters.count(letter) } && results['found'] == true
      @score = "Congratulations! #{word} is in the dictionary and the grid!"
    else
      @score = "sorry #{word} is not valid"
    end
  end
end

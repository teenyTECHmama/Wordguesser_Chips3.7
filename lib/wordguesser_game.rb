class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word,:guesses,:wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses= ""
    @wrong_guesses=""
  end
  def guess(letter)
    raise ArgumentError, 'input nil' if letter == nil
    raise ArgumentError, 'empty input' unless letter.empty? == false
    raise ArgumentError, 'input not a letter' unless /[[:alpha:]]/ =~ letter
    letter.downcase!
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    elsif @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
  end
 # Display word with guesses
 def word_with_guesses
  @word.chars.map{|x| (guesses.include? x) ? x:"-"}.join
end

# Return game status
def check_win_or_lose
  if word_with_guesses.eql? @word
    :win
  elsif @wrong_guesses.length == 7
    :lose
  else
    :play
  end
end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end

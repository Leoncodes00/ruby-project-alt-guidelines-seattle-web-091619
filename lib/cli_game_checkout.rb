class Gamecheckout
  attr_accessor :game_name

  @@all = []

  def initialize(name_of_game)
    @name_of_game = name_of_game
    @@all << self
  end

  def self.all
    @@all
  end
end

class Game < ActiveRecord::Base
  has_many :gameplatforms
  has_many :gamers, through: :gameplatforms
end

#Questions for tomorrow
#Where can I make an @@all for the game class so I can print them

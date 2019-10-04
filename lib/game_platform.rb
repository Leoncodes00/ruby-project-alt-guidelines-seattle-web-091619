class Gameplatform < ActiveRecord::Base
  belongs_to :game
  belongs_to :gamer
end

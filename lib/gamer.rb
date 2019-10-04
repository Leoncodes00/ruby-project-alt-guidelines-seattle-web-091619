class Gamer < ActiveRecord::Base
  has_many :gameplatforms
  has_many :games, through: :gameplatforms
end

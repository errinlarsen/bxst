class Play < ActiveRecord::Base
  belongs_to :game
  has_many :turns
end

class PlaysController < ApplicationController
  def index
    @game = Game.find(params["game_id"])
  end

  def show
    @play = Play.find(params["id"])
  end

  def create
    @game = Game.find(params["game_id"])
    @play = @game.plays.create
    redirect_to game_play_path(@game, @play)
  end
end

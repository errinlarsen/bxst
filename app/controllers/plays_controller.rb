class PlaysController < ApplicationController
  def index
    @game = Game.find(params["game_id"])
    @plays = @game.plays
  end

  def show
    @game = Game.find(params["game_id"])
    @play = @game.plays.find(params["id"])
  end

  def create
    @game = Game.find(params["game_id"])
    @play = @game.plays.create
    redirect_to game_play_path(@game, @play)
  end
end

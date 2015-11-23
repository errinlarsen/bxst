class TurnsController < ApplicationController
  def index
  end

  def show
    @game = Game.find(params["game_id"])
    @play = @game.plays.find(params["play_id"])
    @turn = @play.turns.find(params["id"])
  end

  def create
    @game = Game.find(params["game_id"])
    @play = @game.plays.find(params["play_id"])
    @turn = @play.turns.create
    redirect_to game_play_turn_path(@game, @play, @turn)
  end
end

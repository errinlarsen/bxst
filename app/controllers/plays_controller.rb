class PlaysController < ApplicationController
  def index
  end

  def show
    @play = Plays.find(params["id"])
  end

  def create
    @play = Plays.create
    redirect_to play_path(@play)
  end
end

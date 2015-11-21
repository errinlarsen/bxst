class SessionsController < ApplicationController
  def index
  end

  def show
    @session = Session.find(params["id"])
  end

  def create
    @session = Session.create
    redirect_to session_path(@session)
  end
end

require 'rails_helper'

RSpec.describe TurnsController, type: :controller do
  let(:game) { FactoryGirl.create(:game) }
  let(:play) { FactoryGirl.create(:play, game: game) }
  let(:turn) { FactoryGirl.create(:turn, play: play) }

  describe "GET #index" do
    it "is successful" do
      get :index, game_id: game.id, play_id: play.id
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index, game_id: game.id, play_id: play.id
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "is successful" do
      get :show, game_id: game.id, play_id: play.id, id: turn.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, game_id: game.id, play_id: play.id, id: turn.id
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    it "renders the show template" do
      post :create, game_id: game.id, play_id: play.id
      last_turn_created_path = game_play_turn_path(game, play, play.turns.last)
      expect(response).to redirect_to(last_turn_created_path)
    end
  end
end

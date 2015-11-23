require "rails_helper"

RSpec.describe PlaysController, type: :controller do
  let(:game) { FactoryGirl.create(:game) }

  describe "GET index" do
    it "is successful" do
      get :index, game_id: game.id
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index, game_id: game.id
      expect(response).to render_template(:index)
    end
  end
end

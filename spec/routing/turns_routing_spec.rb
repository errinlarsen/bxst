require "rails_helper"

RSpec.describe "Routes for Turns", type: :routing do
  specify "GET /games/:game_id/plays/:play_id/turns" do
    expect(get: "/games/:id/plays/:id/turns").to be_routable
  end

  specify "POST /games/:game_id/plays/:play_id/turns" do
    expect(post: "/games/:id/plays/:id/turns").to be_routable
  end

  specify "GET /games/:game_id/plays/:play_id/turns/:id" do
    expect(get: "/games/:id/plays/:id/turns/:id").to be_routable
  end
end

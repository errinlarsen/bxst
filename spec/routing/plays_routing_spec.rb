require "rails_helper"

RSpec.describe "Routes for Plays", type: :routing do
  specify "GET /games/:id/plays" do
    expect(get: "/games/:id/plays").to be_routable
  end

  specify "POST /games/:id/plays" do
    expect(post: "/games/:id/plays").to be_routable
  end

  specify "GET /games/:id/plays/:id" do
    expect(get: "/games/:id/plays/:id").to be_routable
  end
end

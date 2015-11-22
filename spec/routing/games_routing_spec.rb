require "rails_helper"

RSpec.describe "Routes for Games", type: :routing do
  it "routes the root path to games#index" do
    expect(get: "/").to route_to "games#index"
  end

  it "GET /games" do
    expect(get: "/games").to be_routable
  end
end

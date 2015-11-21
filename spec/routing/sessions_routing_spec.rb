require "rails_helper"

RSpec.describe "routes for Sessions", type: :routing do
  it "routes the root path to sessions#index" do
    expect(get: "/").to route_to 'sessions#index'
  end

  it "routes to sessions" do
    expect(get: "/sessions").to be_routable
    expect(post: "/sessions").to be_routable
    expect(get: "/sessions/:id").to be_routable
  end
end

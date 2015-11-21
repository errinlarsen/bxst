require "rails_helper"

RSpec.describe "routes for Sessions", type: :routing do
  it "routes to sessions" do
    expect(get: "/sessions/index").to be_routable
  end
end

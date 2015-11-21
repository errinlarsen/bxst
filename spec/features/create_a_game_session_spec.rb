require "rails_helper"

RSpec.feature "Start a session log", type: :feature do
  # As a Basic/eXpert D&D Dungeon Master
  # So I can track resources and time during play sessions
  # I want to create an automated session log

  scenario "User creates a new GameSession" do
    visit sessions_index_path
    click_button "New Session"
    expect(page).to have_content("Session in progress")
  end
end

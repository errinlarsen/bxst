require "rails_helper"

RSpec.feature "Start a play session", type: :feature do
  # As a Basic/eXpert D&D Dungeon Master
  # So I can track resources and time during my play sessions
  # I want to start an automated play session log

    # GIVEN there is a Game
  let(:game) { FactoryGirl.create(:game) }

  scenario "Dungeon Master starts a new Play session" do
    # WHEN I visit the Game's Sessions page
    # AND I click the "Play Session" button
    visit game_plays_path(game)
    click_button "Play session"

    # THEN I see the new Play's ID
    # AND I see "Status: In progress"
    expect(page).to have_content("Play session ID: #{game.plays.last.id}")
    expect(page).to have_content("Status: In progress")
  end
end

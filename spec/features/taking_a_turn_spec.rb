require "rails_helper"

RSpec.feature "Taking a turn", type: :feature do
  # As a Basic/eXpert D&D Dungeon Master
  # So I can be reminded of resources that should have been consumed,
  # and events that should have taken place
  # I want to let the application know that I'm moving
  # the Game's Play session forward a single turn

  let(:game) { FactoryGirl.create(:game) }
  let(:play) { FactoryGirl.create(:play, game: game) }

  scenario "Dungeon Master starts the first turn of a new Play session" do
    # GIVEN there is a Game
    # And that Game has an "In progress" Play without any turns
    # WHEN I visit that Play's page
    # AND I click the "Start play session" button
    # THEN I see the new Turn's ID
    # AND I see "Status: In progress"

    visit game_play_path(game, play)
    click_button "Start play session"
    expect(page).to have_content("Turn ID: #{play.turns.last.id}")
    expect(page).to have_content("Status: In progress")
  end
end


require "rails_helper"

RSpec.feature "Start a session log", type: :feature do
  # As a Basic/eXpert D&D Dungeon Master
  # So I can track resources and time during play sessions
  # I want to create an automated session log

  scenario "User creates a new GameSession" do
    # GIVEN there are no sessions
    expect(Session.count).to be_zero

    # WHEN I visit the Sessions page
    visit sessions_path

    # AND I click the "New Session" button
    click_button "New Session"

    # THEN I see the new Session's ID
    expect(page).to have_content("Session ID: #{Session.last.id}")

    # AND I see "Session in progress"
    expect(page).to have_content("Session in progress")
  end
end

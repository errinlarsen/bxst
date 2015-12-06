require 'spec_helper'
require 'rspec/given'
require 'game/session/turn_details'

RSpec.describe Game::Session::TurnDetails do
  # What we're testing (by default)...
  Given(:subject) { Game::Session::TurnDetails.new }

  describe "#turn" do
    When(:results) { subject.turn }
    Then { results == 1 }

    context "when it's turn 23" do
      Given(:subject) { Game::Session::TurnDetails.new(turn: 23) }
      When(:results) { subject.turn }
      Then { results == 23 }
    end
  end

  describe "#status_alert" do
    When(:results) { subject.status_alert }
    Then { results.include? "Game Turn #1 - hours: 0 minutes: 0" }

    context "when it's turn 23" do
      Given(:subject) { Game::Session::TurnDetails.new(turn: 23) }
      When(:results) { subject.status_alert }
      Then { results.include? "Game Turn #23 - hours: 3 minutes: 40" }
    end
  end

  describe "#advance" do
    When(:next_turn_details) { subject.advance }
    Then { next_turn_details.turn == 2 }

    context "when advancing 2 turns" do
      When(:next_turn_details) { subject.advance(turns: 2) }
      Then { next_turn_details.turn == 3 }
    end

    context "when advanicing 23 turns" do
      When(:next_turn_details) { subject.advance(turns: 23) }
      Then { next_turn_details.turn == 24 }
    end

    context "when it's turn 23" do
      Given(:subject) { Game::Session::TurnDetails.new(turn: 23) }
      When(:next_turn_details) { subject.advance }
      Then { next_turn_details.turn == 24 }

      context "when advancing 2 turns" do
        When(:next_turn_details) { subject.advance(turns: 2) }
        Then { next_turn_details.turn == 25 }
      end

      context "when advancing 23 turns" do
        When(:next_turn_details) { subject.advance(turns: 23) }
        Then { next_turn_details.turn == 46 }
      end
    end
  end

  describe "#total_time" do
    When(:results) { subject.total_time }
    Then { results == 0 }

    context "when it's turn 23" do
      Given(:subject) { Game::Session::TurnDetails.new(turn: 23) }
      When(:results) { subject.total_time }
      Then { results == 220 }
    end
  end

  describe "#hours" do
    When(:results) { subject.hours }
    Then { results == 0 }

    context "when it's turn 23" do
      Given(:subject) { Game::Session::TurnDetails.new(turn: 23) }
      When(:results) { subject.hours }
      Then { results == 3 }
    end
  end

  describe "#minutes" do
    When(:results) { subject.minutes }
    Then { results == 0 }

    context "when it's turn 23" do
      Given(:subject) { Game::Session::TurnDetails.new(turn: 23) }
      When(:results) { subject.minutes }
      Then { results == 40 }
    end
  end
end

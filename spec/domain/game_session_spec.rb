require 'spec_helper'
require 'rspec/given'
require 'game'

RSpec.describe Game::Session do
  Given(:game) { subject }

  describe "alerts are cleared before each turn" do
    context "when no turns have been advanced" do
      Then { expect(game.alerts.count).to eq 3 }
    end

    context "when 1 turn has been advanced" do
      When { game.advance }
      Then { expect(game.alerts.count).to eq 3 }
    end

    context "when 101 turns have been advanced" do
      When { 101.times { game.advance } }
      Then { expect(game.alerts.count).to eq 3 }
    end
  end

  describe "tracking the current turn number and time passed" do
    context "when no turns have been advanced" do
      Then { expect(game.status).to eq "Game Turn #1 - hours: 0 minutes: 0" }
      Then { expect(game.alerts).to include "Game Turn #1 - hours: 0 minutes: 0" }
    end

    context "when 1 turn has been advanced" do
      When { game.advance }
      Then { expect(game.status).to eq "Game Turn #2 - hours: 0 minutes: 10" }
      Then { expect(game.alerts).to include "Game Turn #2 - hours: 0 minutes: 10" }
    end

    context "when 101 turns have been advanced" do
      When { 101.times { game.advance } }
      Then { expect(game.status).to eq "Game Turn #102 - hours: 16 minutes: 50" }
      Then { expect(game.alerts).to include "Game Turn #102 - hours: 16 minutes: 50" }
    end
  end

  describe "tracking wandering monster checks" do
    context "when checking for wandering monsters at the default rate" do
      Invariant { game.wandering_monster_check_rate == Game::DEFAULT_WANDERING_MONSTER_CHECK_RATE }

      context "when no turns have been recorded" do
        Then { expect(game.alerts).to include("DM does not roll for wandering monsters this turn.") }
      end

      context "when 1 turn has been recorded" do
        When { game.advance }
        Then { expect(game.alerts).to include(/DM rolls for wandering monsters: DM rolled a \d/) }
      end
    end

    context "when not checking for wandering monsters" do
      When { game.wandering_monster_check_rate = 0 }
      When { game.advance }
      Then { expect(game.alerts).to include("DM is not checking for wandering monsters.") }
    end
  end

  describe "tracking light sources" do
    context "with no light sources lit" do
      Then { expect(game.pcs_illuminated?).to be false }
      Then { expect(game.alerts).to include("PCs can not see in the dark - do they need a Torch or Lantern lit?") }
    end

    context "with 1 torch lit" do
      When { game.light_torch }
      When { game.advance }
      Then { expect(game.pcs_illuminated?).to be_truthy }
      Then { expect(game.alerts).to include("PCs are illuminated: lit Torches: 1; lit Lanterns: 0.") }
    end

    context "with 1 lantern lit" do
      When { game.light_lantern }
      When { game.advance }
      Then { expect(game.pcs_illuminated?).to be_truthy }
      Then { expect(game.alerts).to include("PCs are illuminated: lit Torches: 0; lit Lanterns: 1.") }
    end

    context "with 1 torch and 1 lantern lit" do
      When { game.light_torch && game.light_lantern }
      When { game.advance }
      Then { expect(game.pcs_illuminated?).to be_truthy }
      Then { expect(game.alerts).to include("PCs are illuminated: lit Torches: 1; lit Lanterns: 1.") }
    end
  end
end

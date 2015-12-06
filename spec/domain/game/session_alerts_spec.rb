require 'spec_helper'
require 'rspec/given'
require 'game'

RSpec.describe "Game::Session#alerts" do
  # Defaults...
  Given(:turn_details) { Game::Session::TurnDetails.new }
  Given(:generator) { Game::RandomEncounterGenerator.new }
  Given(:party) { Game::Party.new }

  # What we're testing...
  Given(:subject) { Game::Session.new(turn_details: turn_details, generator: generator, party: party) }
  When(:results) { subject.alerts }

  context "on the first turn" do
    Given(:turn_details) { Game::Session::TurnDetails.new(turn: 1) }
    Then { results.count == 4 }
    Then { results.include? turn_details.status_alert }
    Then { results.include? "Wandering Monsters: DM does not roll for wandering monsters this turn." }

    context "with no light sources lit" do
      Then { results.include? "Lighting: PCs can not see in the dark - do they need a Torch or Lantern lit?" }
    end
  end

  context "on the second turn" do
    Given(:turn_details) { Game::Session::TurnDetails.new(turn: 2) }
    Then { results.count == 4 }
    Then { results.include? turn_details.status_alert }
    Then { results.any? { |a| a =~ /\AWandering Monsters: DM rolls for wandering monsters: DM rolled a \d/ } }
  end

  context "on the turn after the party takes a rest" do
    Given(:party) { Game::Party.new.take_rest }
    When { subject.advance }
    When(:results_after) { subject.alerts }
    Then { results_after.include? "Movement: Party is fully rested. PCs can walk up to their movement speed this turn." }
  end

  context "on the twenty-third turn" do
    Given(:turn_details) { Game::Session::TurnDetails.new(turn: 23) }
    Then { results.count == 4 }
    Then { results.include? turn_details.status_alert}

    context "when the party is fully rested" do
      Given(:party) { Game::Party.new(fatigue: 0) }
      Then { results.include? "Movement: Party is fully rested. PCs can walk up to their movement speed this turn." }
    end

    context "when the party has 1 turn of fatigue" do
      Given(:party) { Game::Party.new(fatigue: 1) }
      Then { results.include? "Movement: PCs can walk up to their movement speed this turn." }
    end

    context "when the party has 4 turns of fatigue" do
      Given(:party) { Game::Party.new(fatigue: 4) }
      Then { results.include? "Movement: Party must rest in the next turn otherwise they will have a penalty of -1 on all 'to hit' and damage rolls until they have rested for one full turn." }
    end

    context "when the party has 5 turns of fatigue" do
      Given(:party) { Game::Party.new(fatigue: 5) }
      Then { results.include? "Movement: Party is tired! They now have a penalty of -1 on all 'to hit' and damage rolls until they have rested for one full turn." }
    end

    context "when the party has more than 5 turns of fatigue" do
      Given(:party) { Game::Party.new(fatigue: 101) }
      Then { results.include? "Movement: Party is tired! They now have a penalty of -1 on all 'to hit' and damage rolls until they have rested for one full turn." }
    end

    context "with 1 torch lit" do
      Given(:party) { Game::Party.new.light_torch }
      Then { results.include? "Lighting: PCs are illuminated: lit Torches: 1; lit Lanterns: 0." }
    end

    context "with 1 lantern lit" do
      Given(:party) { Game::Party.new.light_lantern }
      Then { results.include? "Lighting: PCs are illuminated: lit Torches: 0; lit Lanterns: 1." }
    end

    context "with 1 torch and 1 lantern lit" do
      Given(:party) { Game::Party.new.light_lantern.light_torch }
      Then { results.include? "Lighting: PCs are illuminated: lit Torches: 1; lit Lanterns: 1." }
    end

    context "when checking for wandering monsters with a rate of 0" do
      Given(:generator) { Game::RandomEncounterGenerator.new(check_rate: 0) }
      Then { results.include? "Wandering Monsters: DM is not checking for wandering monsters." }
    end
  end
end

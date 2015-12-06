require 'game/party'
require 'game/random_encounter_generator'
require 'game/session'

module Game
  DEFAULT_PARTY = Party
  DEFAULT_GENERATOR = RandomEncounterGenerator
  DEFAULT_RANDOM_ENCOUNTER_CHECK_RATE = 2
  RANDOM_ENCOUNTER_CHECK_DIE = 6
end

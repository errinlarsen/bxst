module Game
  class RandomEncounterGenerator
    attr_accessor :check_rate

    def initialize(**options)
      @check_rate = options.fetch(:check_rate, Game::DEFAULT_RANDOM_ENCOUNTER_CHECK_RATE)
      @check_die = options.fetch(:check_die, Game::RANDOM_ENCOUNTER_CHECK_DIE)
    end

    def check_alert(turn:)
      return no_check_alert if check_rate.zero?
      return check_roll_alert if check_for_turn?(turn)
      "Wandering Monsters: DM does not roll for wandering monsters this turn."
    end

    private def check_roll
      1.upto(@check_die).to_a.sample
    end

    private def check_for_turn?(turn)
      (turn % check_rate) == 0
    end

    private def no_check_alert
      "Wandering Monsters: DM is not checking for wandering monsters."
    end

    private def check_roll_alert
      "Wandering Monsters: DM rolls for wandering monsters: DM rolled a #{check_roll}."
    end
  end
end

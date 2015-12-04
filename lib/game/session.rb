require 'forwardable'
require 'game/clock'

module Game
  class Session
    extend Forwardable

    attr_reader :alerts
    attr_accessor :wandering_monster_check_rate
    def_delegators :@clock, :turn, :hours, :minutes

    def initialize
      @wandering_monster_check_rate = Game::DEFAULT_WANDERING_MONSTER_CHECK_RATE
      @light_sources = []
      @clock = Game::Clock.new
      initialize_turn
    end

    def status
      "Game Turn ##{turn} - hours: #{hours} minutes: #{minutes}"
    end

    def advance
      @clock.advance
      initialize_turn
    end

    def light_lantern
      @light_sources << :lantern
    end

    def light_torch
      @light_sources << :torch
    end

    def pcs_illuminated?
      !@light_sources.empty?
    end

    def count_light_sources
      @light_sources.count
    end

    private def initialize_turn
      @alerts = []
      @alerts << status
      @alerts << light_sources_alert
      @alerts << wandering_alert
    end

    private def torches_count
      @light_sources.count(:torch)
    end

    private def lanterns_count
      @light_sources.count(:lantern)
    end

    private def light_sources_alert
      return illuminated_light_sources_alert if pcs_illuminated?
      "PCs can not see in the dark - do they need a Torch or Lantern lit?"
    end

    private def illuminated_light_sources_alert
      "PCs are illuminated: " <<
        "lit Torches: #{torches_count}; " <<
        "lit Lanterns: #{lanterns_count}."
    end

    private def wandering_rate
      @wandering_monster_check_rate
    end

    private def wandering_roll
      1.upto(6).to_a.sample
    end

    private def check_wandering?
      (turn % wandering_rate) == 0
    end

    private def wandering_alert
      return no_wandering_alert if wandering_rate.zero?
      return wandering_roll_alert if check_wandering?
      "DM does not roll for wandering monsters this turn."
    end

    private def no_wandering_alert
      "DM is not checking for wandering monsters."
    end

    private def wandering_roll_alert
      "DM rolls for wandering monsters: DM rolled a #{wandering_roll}."
    end
  end
end

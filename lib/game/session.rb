require 'game/session/turn_details'

module Game
  class Session
    attr_reader :alerts

    DEFAULT_TURN_DETAILS = TurnDetails

    def initialize(**options)
      @turn_details = options.fetch(:turn_details, DEFAULT_TURN_DETAILS.new)
      @party = options.fetch(:party, DEFAULT_PARTY.new)
      @generator = options.fetch(:generator, DEFAULT_GENERATOR.new)
      collect_alerts
    end

    def light_lantern
      @party = @party.light_lantern
    end

    def light_torch
      @party = @party.light_torch
    end

    def take_rest
      @party = @party.take_rest
    end

    def advance(turns: 1)
      @turn_details = @turn_details.advance(turns: turns)
      @party = @party.advance(turns: turns)
      collect_alerts
    end

    private def collect_alerts
      @alerts = []
      @alerts << @turn_details.status_alert
      @alerts << @party.light_sources_alert
      @alerts << @party.movement_alert
      @alerts << @generator.check_alert(turn: @turn_details.turn)
    end
  end
end

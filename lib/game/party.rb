module Game
  class Party
    attr_reader :fatigue, :light_sources

    def initialize(fatigue: 0, light_sources: [])
      @fatigue = fatigue
      @light_sources = light_sources
    end

    def advance(turns: 1)
      updated = @fatigue + turns
      self.class.new(fatigue: updated, light_sources: @light_sources)
    end

    def light_lantern
      updated = @light_sources + [:lantern]
      self.class.new(fatigue: @fatigue, light_sources: updated)
    end

    def light_torch
      updated = @light_sources + [:torch]
      self.class.new(fatigue: @fatigue, light_sources: updated)
    end

    def take_rest
      updated = -1
      self.class.new(fatigue: updated, light_sources: @light_sources)
    end

    def almost_tired?
      @fatigue == 4
    end

    def fully_rested?
      @fatigue.zero?
    end

    def illuminated?
      @light_sources.any?
    end

    def tired?
      @fatigue > 4
    end

    def light_sources_alert
      return illuminated_light_sources_alert if illuminated?
      "Lighting: PCs can not see in the dark - do they need a Torch or Lantern lit?"
    end

    def movement_alert
      return fully_rested_alert if fully_rested?
      return almost_tired_alert if almost_tired?
      return tired_alert if tired?
      "Movement: PCs can walk up to their movement speed this turn."
    end

    private def illuminated_light_sources_alert
      "Lighting: PCs are illuminated: " <<
        "lit Torches: #{light_sources.count(:torch)}; " <<
        "lit Lanterns: #{light_sources.count(:lantern)}."
    end

    private def fully_rested_alert
      "Movement: Party is fully rested. PCs can walk " <<
      "up to their movement speed this turn."
    end

    private def almost_tired_alert
      "Movement: Party must rest in the next turn otherwise they will have " <<
      "a penalty of -1 on all 'to hit' and damage rolls until they have " <<
      "rested for one full turn."
    end

    private def tired_alert
      "Movement: Party is tired! They now have " <<
      "a penalty of -1 on all 'to hit' and damage rolls until they have " <<
      "rested for one full turn."
    end
  end
end

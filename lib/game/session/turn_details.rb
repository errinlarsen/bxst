module Game
  class TurnDetails
    attr_reader :turn

    def initialize(turn: 1)
      @turn = turn
    end

    def status_alert
      "Game Turn ##{@turn} - hours: #{hours} minutes: #{minutes}"
    end

    def advance(turns: 1)
      self.class.new(turn: @turn + 1)
    end

    def total_time
      @turn * 10 - 10
    end

    def hours
      total_time / 60
    end

    def minutes
      total_time % 60
    end
  end
end

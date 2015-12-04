module Game
  class Clock
    attr_reader :turn

    def initialize
      @turn = 1
    end

    def advance
      @turn += 1
    end

    def time
      @turn * 10 - 10
    end

    def hours
      time / 60
    end

    def minutes
      time % 60
    end
  end
end

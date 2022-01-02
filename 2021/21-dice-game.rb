class Dice

    def initialize
    end

    def play
        turn = "1"
        moves = 1
        position1 = 2
        position2 = 8
        score1 = 0
        score2 = 0
        count = 0
        while (score1 < 1000 && score2 < 1000) do
            case turn
            when "1"
              position1 += 3*moves + 3
              position1 = position1 > 10 ? (position1%10 == 0 ? 10 : position1%10)  : position1

              score1 += position1
              turn = "2"
            when "2"
               position2 += 3*moves + 3
               position2 = position2 > 10 ? (position2%10 == 0 ? 10 : position2%10) : position2

               score2 += position2
               turn = "1"
            end
            moves += 3
            count += 1
        end
        p score1
        p score2
        p count
        p moves
    end
end

d = Dice.new
d.play
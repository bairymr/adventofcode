class Bingo
    def initialize
        @data = []
        File.open("input4-actual-data.data", "r") do |f|
            f.each_line do |line|
                @data = line.chomp.split(",").map { |c| c.to_i }
            end
        end

        @bingo_cards = []
        File.open("input4-actual-bingo.data", "r") do |f|
            bingo = []
            i = 0
            f.each_line do |line|
                row = line.chomp.split(' ').map { |c| c.to_i }
                if row.empty?
                    i = 0
                else
                    bingo << row
                    i += 1
                    if i % 5 == 0
                        @bingo_cards << bingo.clone
                        bingo = []
                    end
                end
        end
      end
    end

    def print
        p @data
        p @bingo_cards[1]
    end

    def find_match(ar, bingo)
        i , j = 0, 0
        #row match
        while (i < bingo.length) do
            if (bingo[i] - ar).empty?
                return true
            end
            i += 1
        end

        while (j < bingo[0].length) do
            i = 0
            col = []
            while (i < bingo.length) do
                col << bingo[i][j]
                i += 1
            end
            if (col - ar).empty?
                return true
            end
            j += 1
        end

        return false
    end

    def find_bingo
        ar = @data[0..4]
        data_count = 5
        found_match = false
        while (!found_match) do
            i = 0
            while (i < @bingo_cards.length) do
                found_match = find_match(ar, @bingo_cards[i])
                if (found_match)
                    break
                end
                i += 1
            end
            if (!found_match)
                ar << @data[data_count]
                data_count += 1
            end
        end

        #p i
        #p ar

        r , c = 0, 0
        sum = 0
        matched_ar =  @bingo_cards[i]
        while (r < matched_ar.length) do
            c = 0
            while (c < matched_ar.length) do
                if !ar.include? matched_ar[r][c]
                    sum += matched_ar[r][c]
                end
                c += 1
            end
             r += 1
        end
        p sum*ar[-1]
        #p ar[-1]
    end

    def find_last_bingo
        ar = @data[0..4]
        data_count = 5
        found_match = false
        matched_bingo_card = []
        while (matched_bingo_card.length < @bingo_cards.length) do
            i = 0
            while (i < @bingo_cards.length) do
                if !matched_bingo_card.include? i
                    found_match = find_match(ar, @bingo_cards[i])
                    if (found_match)
                        matched_bingo_card << i
                    end
                end
                i += 1
            end
            if (!found_match)
                ar << @data[data_count]
                data_count += 1
            end
        end

        p matched_bingo_card
        p ar

        r , c = 0, 0
        sum = 0
        matched_ar =  @bingo_cards[matched_bingo_card[-1]]
        while (r < matched_ar.length) do
            c = 0
            while (c < matched_ar.length) do
                if !ar.include? matched_ar[r][c]
                    sum += matched_ar[r][c]
                end
                c += 1
            end
             r += 1
        end
        p sum
        p sum*ar[-1]

    end


end

b = Bingo.new
#b.find_bingo
b.find_last_bingo

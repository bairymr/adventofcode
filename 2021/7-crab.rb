class Crab
    def initialize
        @position = []
        File.open("input7-actual.data", "r") do |f|
            f.each_line do |line|
                @position = line.split(',').map { |n| n.to_i }
            end
        end
    end

    def find_cheap_spot
        min, max  = @position.min, @position.max

        i = min
        best_distance = nil
        while (i  <= max) do
            distance = 0
            step = 0
            @position.each do |p|
                break if best_distance && distance > best_distance
                n = (p - i).abs
                distance += n*(n+1)/2
            end
            best_distance = distance if best_distance.nil? || best_distance > distance
            i += 1
        end

        best_distance
    end

end

c = Crab.new
p c.find_cheap_spot


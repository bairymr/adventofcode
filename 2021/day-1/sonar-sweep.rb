class SonarSweep
    def initialize
        @depth = []
        @sliding_window = []
        index = 0
        File.open("input.data", "r") do |f|
            f.each_line do |line|
                @depth << line.to_i
                @sliding_window << line.to_i
                @sliding_window[index-2] += @sliding_window[index-1] + @sliding_window[index] if index >= 2
                index += 1
            end
        end
        if index >= 2
            @sliding_window.pop
            @sliding_window.pop
        end
    end

    def find_increasing_depth_single_window
        find_increasing_depth(@depth)
    end

    def find_increasing_depth_sliding_window
        find_increasing_depth(@sliding_window)
    end

    def find_increasing_depth(array)
        count = 0
        #p @depth
        array.each_with_index do |depth, index|
            count += 1 if index > 0 && depth > array[index-1]
        end
        count
    end
end

s = SonarSweep.new
p s.find_increasing_depth_sliding_window


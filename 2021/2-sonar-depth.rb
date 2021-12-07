class SonarSweep
    def initialize
        @horizontal = 0
        @depth = 0
        @aim = 0
        File.open("input-day2.data", "r") do |f|
            f.each_line do |line|
               direction, num = line.split
               case direction
               when 'forward'
                  @horizontal += num.to_i
                  @depth += @aim * num.to_i
               when 'up'
                  @aim -= num.to_i
               when 'down'
                  @aim += num.to_i
               end
            end
        end
    end
end

s = SonarSweep.new
p "aim #{s.instance_variable_get(:@aim)}"
p "horizontal #{s.instance_variable_get(:@horizontal)}"
p "depth #{s.instance_variable_get(:@depth)}"
p "total #{s.instance_variable_get(:@horizontal) * s.instance_variable_get(:@depth)}"


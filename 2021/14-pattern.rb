class Pattern
    def initialize
        @map_data = {}
        File.open("input14-actual.data", "r") do |f|
            f.each_line do |line|
                input1, input2 = line.chomp.split('->').map { |c| c.strip }
                @map_data[input1] = input2
            end
        end
    end

    def find_pattern(str)

       new_str = ""
       ix = 0
       while (ix <= str.length-2) do
          if @map_data[str[ix..ix+1]]
             new_str << str[ix] + @map_data[str[ix..ix+1]]
             ix += 1
          else
            new_str << str[ix]
            ix += 1
          end
       end

       new_str + str[-1]
    end

    def find_max_min(pattern)
       count_map = {}
       pattern.each_char do |c|
          if count_map[c].nil?
            count_map[c] = 1
          else
            count_map[c] += 1
          end
       end

       max = count_map.values.max
       min = count_map.values.min
       p max-min
    end

    def print
        p @map_data
    end


    def find_pattern_v2(pattern_map_data)
        copy_pattern_map_data = pattern_map_data.clone

        pattern_map_data.keys.each |k| do

        end
    end

end

p = Pattern.new
#p.print
pattern = "VCOPVNKPFOOVPVSBKCOF"
#p p.find_pattern("NCNBCHB")
count = 1
40.times do
    pattern =  p.find_pattern(pattern)
    p count
    count += 1
end

p.find_max_min(pattern)

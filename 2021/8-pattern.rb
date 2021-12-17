class Pattern
    def initialize
        @input = []
        @output = []
        File.open("input8-actual.data", "r") do |f|
            f.each_line do |line|
                @input << line.split('|')[0].split(' ')
                @output << line.split('|')[1].split(' ')
            end
        end
        #@input.flatten!
        #@output.flatten!
    end

    def input
        @input
    end

    def output
        @output
    end

    def find_count
       count = 0
       @output.each do |o|
          count += 1 if [2,3,4,7].include? o.length
       end
       count
    end

    def find_pattern(inputs, outputs)
        pattern_map = {}
        #find 1/4/7/8
        inputs.each do |inp|
            case inp.length
            when 2
                pattern_map[inp] = 1
            when 4
                pattern_map[inp] = 4
            when 3
                pattern_map[inp] = 7
            when 7
                pattern_map[inp] = 8
            end
        end

        pattern_4 = pattern_map.select { |k,v| v == 4 }.keys.first

        len_6 = inputs.select { |i| i.length == 6}
        len_6.each do |inp|
            if str_contains(inp, pattern_4)
                pattern_map[inp] = 9
                break
            end
        end

        len_5 = inputs.select { |i| i.length == 5}
        pattern_1 = pattern_map.select { |k,v| v == 1 }.keys.first

        len_5.each do |inp|
            if str_contains(inp, pattern_1)
                pattern_map[inp] = 3
                break
            end
        end

        len_5 = inputs.select { |i| i.length == 5 && pattern_map[i].nil? }
        pattern_9 = pattern_map.select { |k,v| v == 9 }.keys.first

        #p len_5
        len_5.each do |inp|
            if str_contains(pattern_9, inp)
                pattern_map[inp] = 5
            else
                pattern_map[inp] = 2
            end
        end

        pattern_7 = pattern_map.select { |k,v| v == 7 }.keys.first
        len_6 = inputs.select { |i| i.length == 6 && pattern_map[i].nil? }
        len_6.each do |inp|
            if str_contains(inp, pattern_7)
                pattern_map[inp] = 0
            else
                pattern_map[inp] = 6
            end
        end
        patterns = pattern_map.keys
        nums = ""
        outputs.each do |op|
           matched_pattern = patterns.select {|k|  anagrams(k, op) }.first
           nums << pattern_map[matched_pattern].to_s
        end

        p nums.to_i
    end

    # does s1 contain all characters of s2
    def str_contains (s1, s2)
        return false if s1.nil? || s2.nil?
        s2.each_char do |s_ch|
            if !s1.include? s_ch
                return false
            end
        end
        return true
    end

    def anagrams (s1, s2)
        return false if s1.nil? || s2.nil?
        return false if s1.length != s2.length

        return str_contains(s1, s2)
    end
end

p = Pattern.new
#p p.find_count

sum = 0
p.input.each_with_index do |v,ix|
 sum += p.find_pattern(v, p.output[ix])
end
#p.find_pattern(p.input[6], p.output[6])
p sum

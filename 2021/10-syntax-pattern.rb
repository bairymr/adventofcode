class SynatxPattern
    def initialize
        @input = []
        @matches = {}
        @matches['('] = ')'
        @matches['{'] = '}'
        @matches['<'] = '>'
        @matches['['] = ']'

        @points = {}
        @points[')'] = 3
        @points[']'] = 57
        @points['}'] = 1197
        @points['>'] = 25137

        File.open("input10-actual.data", "r") do |f|
            f.each_line do |line|
                @input << line.chomp
            end
        end
    end

    def match

        score = 0
        @input.each do |row|
            stack = []
            row.each_char do |ch|
               if @matches[ch]
                  stack << ch
               else
                   open_ch = stack[-1]
                   open_match = @matches.select { |k,v| v == ch }
                   if open_match.nil?
                      break
                   elsif open_ch != open_match.keys.first
                      #print "Expected #{@matches[open_ch]}"
                      #print " Found #{ch}"
                      #print row
                      p ch
                      p @points[ch]
                      score += @points[ch]
                      break
                   else
                     stack.pop
                   end
               end
            end
        end
        p score
    end
end

s = SynatxPattern.new
s.match

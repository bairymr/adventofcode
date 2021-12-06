class Hydro
    def initialize
        @data = []
        File.open("input5-actual-data.data", "r") do |f|
            f.each_line do |line|
                data = line.chomp.split("->")
                row1,col1 = data[0].split(',').map {|n| n.to_i }
                row2,col2 = data[1].split(',').map {|n| n.to_i }

                if col1 == col2
                    min_row = [row1, row2].min
                    max_row = [row1, row2].max
                    a = @data[col1]
                    if a.nil?
                       @data[col1] = []
                       a = @data[col1]
                    end
                    while (min_row <= max_row) do
                       if a[min_row].nil?
                         a[min_row] = 1
                       else
                        a[min_row] += 1
                       end
                       min_row += 1
                    end
                elsif row1 == row2
                    min_col = [col1, col2].min
                    max_col = [col1, col2].max
                    while (min_col <= max_col)  do
                        a = @data[min_col]
                        if a.nil?
                            @data[min_col] = []
                            a = @data[min_col]
                        end
                        if a[row1].nil?
                            a[row1] = 1
                        else
                            a[row1] += 1
                        end
                        min_col += 1
                    end
                else
                   min_col = [col1, col2].min
                   start_row = min_col == col1 ? row1 : row2
                   end_row = start_row == row1 ? row2 : row1

                   start_col = min_col
                   end_col = min_col == col1 ? col2 : col1

                   i = start_row
                   j = start_col

                   if start_row > end_row
                      while (i >= end_row) do
                         a = @data[j]
                         if a.nil?
                            @data[j] = []
                            a = @data[j]
                         end
                         if a[i].nil?
                            a[i] = 1
                         else
                            a[i] += 1
                         end
                         i -= 1
                         j += 1
                      end
                   else
                    while (i <= end_row) do
                       a = @data[j]
                       if a.nil?
                          @data[j] = []
                          a = @data[j]
                       end
                       if a[i].nil?
                          a[i] = 1
                       else
                          a[i] += 1
                       end
                       i += 1
                       j += 1
                    end
                end
                end
            end
        end
    end

    def print
       p @data
    end

    def count_max
        row = @data.length
        i = 0
        sum = 0
        while (i < row) do
            b = @data[i]
            sum += b.select { |n| !n.nil? && n >= 2}.count if !b.nil?
            i += 1
        end
        sum
    end
end

h = Hydro.new
p h.count_max


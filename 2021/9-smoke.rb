class Smoke
    def initialize
        @input = []
        File.open("input9-actual.data", "r") do |f|
            f.each_line do |line|
                row = []
                line.chomp.each_char do |ch|
                    row << ch.to_i
                end
                @input << row
            end
        end
    end

    def print
        p @input
    end

    def find_risk
        i,j = 0,0
        row_length = @input.length
        col_length = @input[0].length
        risk = 0
        path = {}
        basins = []
        @input.each do |row|
            j = 0
            row.each do |r|
                if bounds_low(i,j,row_length,col_length)
                    risk += @input[i][j] + 1
                    path[create_key(i,j)] = true
                    find_adjacent_points(i,j, row_length, col_length, path, @input[i][j])
                    if basins.empty?
                        basins << path.keys.length
                    else
                        basins << path.keys.length - basins.sum
                    end
                end
                j += 1
            end
            i += 1
        end

        basins = basins.sort.reverse

        p basins
        p basins[0] * basins[1] * basins[2]


        return risk
    end

    def find_adjacent_points(i,j,row, col, path, val)

        neighbors_r = [i-1, i+1, i, i]
        neighbors_c = [j, j, j-1, j+1]

        for ix in 0..3 do
            if matches_condition(neighbors_r[ix], neighbors_c[ix], row, col, path, val)
                path[create_key(neighbors_r[ix], neighbors_c[ix])] = true
                find_adjacent_points(neighbors_r[ix], neighbors_c[ix], row, col, path, @input[neighbors_r[ix]][neighbors_c[ix]])
            end
        end
    end


    def matches_condition(i,j, row, col,  path, val)
        #p "#{i}, #{j}, #{row}, #{col},  #{path}, #{val}"
        return i >=0 && j >= 0 && i < row && j < col && @input[i][j] != 9 && @input[i][j] > val && path[create_key(i,j)].nil?
    end

    def create_key(i,j)
        i.to_s + "_" + j.to_s
    end

    def bounds_low(i,j,row,col)
        is_low = true
        if i-1 >= 0 && @input[i][j] >= @input[i-1][j]
           is_low = false
        end
        if is_low && i+1 < row && @input[i][j] >= @input[i+1][j]
            is_low = false
        end
        if is_low && j-1 >= 0 && @input[i][j] >= @input[i][j-1]
            is_low = false
        end
        if is_low && j+1 < col && @input[i][j] >= @input[i][j+1]
          is_low = false
        end

        is_low
    end
end

s = Smoke.new
#s.print
p s.find_risk

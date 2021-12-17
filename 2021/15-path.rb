class Path
    def initialize
        @matrix = []
        File.open("input15-actual.data", "r") do |f|
            f.each_line do |line|
                row = []
                line.chomp.each_char do |c|
                   row << c.to_i
                end
                @matrix << row
            end
        end
        @row = @matrix.length
        @col = @matrix[0].length
    end

    def find_path(map,i,j)

        return if i >= @col || j >= @row

        return unless map[create_key(i,j)].nil?

        if i == @col-1 && j == @row-1
            map[create_key(i,j)] = @matrix[i][j]
            return
         end

        if map[create_key(i+1,j)].nil?
            find_path(map, i+1, j)
        end


        if map[create_key(i,j+1)].nil?
            find_path(map, i, j+1)
        end

        if !map[create_key(i+1,j)].nil? && !map[create_key(i,j+1)].nil?
            map[create_key(i,j)] = @matrix[i][j] + [map[create_key(i+1,j)],  map[create_key(i,j+1)]].min
        elsif !map[create_key(i,j+1)].nil?
           map[create_key(i,j)] = @matrix[i][j] + map[create_key(i,j+1)]
        elsif !map[create_key(i+1,j)].nil?
           map[create_key(i,j)] = @matrix[i][j] + map[create_key(i+1,j)]
       end

    end

    def print_map(map)
        i,j = 0,0

        while (i < @row) do
          j = 0
          while (j < @col) do
            print map[create_key(i,j)].to_s + " "
            j += 1
          end
          print "\n"
          i += 1
        end
    end

    def find_path_v2
        path = []
        i,j = 0,0

        while (i < @row) do
          j = 0
          row = []
          while (j < @col) do
            j += 1
            path << row
          end
          i += 1
        end
        path[@row-1][@col-1] = @matrix[@row-1][@col-1]
        path[@row-2][@col-1] = @matrix[@row-2][@col-1] + @matrix[@row-1][@col-1]
        path[@row-1][@col-2] = @matrix[@row-1][@col-2] + @matrix[@row-1][@col-1]


    end

    def create_key(i,j)
        i.to_s + "_" + j.to_s
    end

    def matrix
        @matrix
    end

end

p = Path.new
map = {}
p.find_path(map,0,0)
p map[p.create_key(0,0)] - p.matrix[0][0]
p.print_map(map)
#p map




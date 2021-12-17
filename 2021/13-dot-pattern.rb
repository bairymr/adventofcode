class Dot
    def initialize
        @input = []
        max_row, max_col = 0,0
        File.open("input13-actual.data", "r") do |f|
            f.each_line do |line|
                @input <<  line.chomp.split(',').map { |c| c.to_i }
                max_row = @input[-1][1] if @input[-1][1] > max_row
                max_col = @input[-1][0] if @input[-1][0] > max_col
            end
        end
        i,j = 0,0
        max_row += 1
        max_col += 1
        @matrix = []
        while (i < max_row) do
            j = 0
            row = []
            while (j < max_col) do
                row[j] = 0
                row[j] = 1 if @input.select { |c| c[0] == j && c[1] == i }.length > 0
                j += 1
            end
            @matrix << row
            i += 1
        end
    end

    def print
        p @matrix
        count = 0
        @matrix.each { |row| row.each { |c|  count += 1 if c == 1 } }
        p count
    end

    def fold_up_on_y(y)
        new_matrix = []
        i,j = 0,0
        col = @matrix[0].length
        row = @matrix.length
        new_matrix_row = 0
        while (i < y) do
            new_matrix << @matrix[i]
            new_matrix_row += 1
            i += 1
        end
        i += 1
        new_matrix_row -=  1


        while (i < row) do
            j = 0
            while (j < col) do
                new_matrix[new_matrix_row][j] = new_matrix[new_matrix_row][j] == 0 ? @matrix[i][j] : new_matrix[new_matrix_row][j]
                j += 1
            end
            i += 1
            new_matrix_row -= 1
        end
        #p new_matrix
        @matrix = new_matrix
    end

    def fold_up_on_x(x)
        new_matrix = []
        i,j = 0,0
        col = @matrix[0].length
        row = @matrix.length
        new_matrix_col = 0

        while (i < row) do
            new_matrix << []
            i += 1
        end
        i = 0
        j = x+1
        new_matrix_col = x-1


        while (j < col && new_matrix_col >= 0) do
            i = 0
            while (i < row) do
                new_matrix[i][new_matrix_col] = @matrix[i][new_matrix_col] == 0 ? @matrix[i][j] : @matrix[i][new_matrix_col]
                i += 1
            end
            j += 1
            new_matrix_col -= 1
        end
        #p new_matrix
        @matrix = new_matrix
    end
end

d = Dot.new
#d.print
#d.fold_up_on_y(7)
#d.print
=begin
fold along x=655
fold along y=447
fold along x=327
fold along y=223
fold along x=163
fold along y=111
fold along x=81
fold along y=55
fold along x=40
fold along y=27
fold along y=13
fold along y=6
=end
d.fold_up_on_x(655)
d.fold_up_on_y(447)
d.fold_up_on_x(327)
d.fold_up_on_y(223)
d.fold_up_on_x(163)
d.fold_up_on_y(111)
d.fold_up_on_x(81)
d.fold_up_on_y(55)
d.fold_up_on_x(40)
d.fold_up_on_y(27)
d.fold_up_on_y(13)
d.fold_up_on_y(6)

d.print

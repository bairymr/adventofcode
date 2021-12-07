class BinaryDiagnostic
    def initialize
        @data = []
        File.open("input3-actual.data", "r") do |f|
            f.each_line do |line|
                @data << line.chomp
            end
        end
        @zero_count = []
        @one_count = []
        @length_of_str = @data[0].length
        ix = 0
        while (ix < @length_of_str) do
             @zero_count << 0
             @one_count << 0
             ix += 1
        end
        @data.each do |d|
            ix = 0
            d.each_char do |c|
               @zero_count[ix] += 1 if c == '0'
               @one_count[ix] += 1 if c == '1'
               ix += 1
            end
        end

    end

    def find_max_count(data, ix)
        zero_count = 0
        one_count = 0
        data.each do |d|
            zero_count += 1 if d[ix] == '0'
            one_count += 1 if d[ix] == '1'
        end
        return {'0'=> zero_count, '1'=> one_count}
    end

    def find_life_support_rating

       ix = 0
       oxygen_rate = []
       co2_rate = []

       copy_of_data = @data.clone
       second_copy = []

       while ix < @length_of_str && copy_of_data.length > 1 do
          counts = find_max_count(copy_of_data, ix)
          max_char = (counts['1'] >= counts['0'] ? '1' : '0')
          second_copy = copy_of_data.select { |c| c[ix] == max_char }

          ix += 1

          copy_of_data = second_copy.clone
          #p copy_of_data
          second_copy = []
       end

       oxygen_rate =  copy_of_data.clone

       copy_of_data = @data.clone
       second_copy = []
       ix = 0

       while ix < @length_of_str && copy_of_data.length > 1 do

        counts = find_max_count(copy_of_data, ix)
        max_char = (counts['1'] >= counts['0'] ? '0' : '1')
        second_copy = copy_of_data.select { |c| c[ix] == max_char }

        ix += 1

        copy_of_data = second_copy.clone
        #p copy_of_data
        second_copy = []
        end

     co2_rate = copy_of_data.clone

     p binary_to_decimal(oxygen_rate[0])
     p binary_to_decimal(co2_rate[0])
     p binary_to_decimal(oxygen_rate[0]) * binary_to_decimal(co2_rate[0])
    end

    def binary_to_decimal(binary)
        ix = @length_of_str-1
        ix2 = 0
        decimal = 0
        p binary
        while (ix2 < @length_of_str) do

           decimal += 2.pow(ix)*binary[ix2].to_i
           #p decimal
           ix2 += 1
           ix -= 1
        end
        decimal
    end

    def find_gamma_and_epsilon_rate
        ix = 0
        gamma_rate = []
        epsilon_rate = []
        while  (ix < @length_of_str) do
            gamma_rate << (@zero_count[ix] > @one_count[ix] ? '0' : '1')
            epsilon_rate << (@zero_count[ix] > @one_count[ix] ? '1' : '0')
            ix += 1
        end

        p gamma_rate
        p epsilon_rate

        ix = @length_of_str-1
        ix2 = 0
        gamma = 0
        epsilon = 0
        while (ix2 < @length_of_str) do
           gamma += 2.pow(ix)*gamma_rate[ix2].to_i
           epsilon += 2.pow(ix)*epsilon_rate[ix2].to_i
           ix2 += 1
           ix -= 1
        end

        p gamma
        p epsilon
        p gamma* epsilon
    end
end

b = BinaryDiagnostic.new
#b.find_gamma_and_epsilon_rate
b.find_life_support_rating

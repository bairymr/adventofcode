class LanternFish
    def initialize
        @age = []
        File.open("input6-actual.data", "r") do |f|
            f.each_line do |line|
                @age = line.split(',').map { |n| n.to_i }
            end
        end
    end

    def count(num_of_day)
        i = 0
        while (i < num_of_day) do
           count = @age.length
           j = 0
           while (j < count) do
               @age[j] = @age[j]-1
               if @age[j] < 0
                  @age[j] = 6
                  @age << 8
               end
               j += 1
           end
           p "#{i} #{@age.length}"
           i += 1
        end
    end

    def count_v2(num_of_day)
       age_map = {}
p @age
       @age.each do |a|
         if age_map[a].nil?
            age_map[a] = 1
         else
            age_map[a] += 1
         end
         #p a
         #p age_map
       end
       #p age_map
       num_of_day.times do
           age_map_clone = {}
           keys = age_map.keys
           keys.each do |k|
              age_map_clone[k-1] = age_map[k]
           end
           #p age_map_clone
           if age_map_clone[-1]
              age_map_clone[6] += age_map_clone[-1] if age_map_clone[6]
              age_map_clone[6] = age_map_clone[-1] if age_map_clone[6].nil?

              age_map_clone[8] += age_map_clone[-1] if age_map_clone[8]
              age_map_clone[8] = age_map_clone[-1] if age_map_clone[8].nil?

              age_map_clone.delete(-1)
           end
           age_map = age_map_clone.clone
       end
       sum = 0
       #p age_map
       age_map.keys.each do |k|
           sum += age_map[k]
       end
       p sum
    end

    def print
        #p @age
        #p @age.length

    end
end

l = LanternFish.new
#l.count(80)
#l.print
l.count_v2(256)


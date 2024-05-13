# Programming Languages
# Lecture 07: Object State

class Knight
    def introduce
        puts "Hello, I am a Knight!"
        @ap = 3
        @hp = 7
    end

    def method_2
        @ap = 1
        @hp1 = 12
        nil
    end

    def apply_damage dam
        if @ap == 0
            @hp -= dam

            if @hp <= 0
                puts "I am dead!"
            else
                puts "I am still slive!"
            end

        elsif dam > @ap
            new_dam = dam - @ap
            @ap = 0
            self.apply_damage new_dam
        else
            @ap -= dam
            puts "I am still alive!"
        end
    end
end

knight = Knight.new
knight.introduce
knight.apply_damage 8
knight.apply_damage 12

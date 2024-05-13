# Programming Languages
# Lecture 07: Initialization

class Knight
    def initialize(hp = 15, ap = 3)
        @hp = hp
        @ap = ap
    end

    def introduce
        puts "Hello, I am a Knight!"
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

knight = Knight.new(15, 3)
knight.introduce
knight.apply_damage 8
knight.apply_damage 12

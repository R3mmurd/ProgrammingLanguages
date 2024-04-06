# Programming Languages
# Lecture 07: Aliasing

class Knight
    def introduce
        puts "Hello, I am a Knight!"
        @hp = 15
        @ap = 3
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

knight1 = Knight.new
knight1.introduce
knight2 = knight1
knight1.apply_damage 8
knight2.apply_damage 12

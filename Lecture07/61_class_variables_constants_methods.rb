# Programming Languages
# Lecture 07: Class variables, constants, and methods

class Knight

    @@current_id = 0

    Max_Hp = 50
    Max_Ap = 20

    def initialize(hp, ap)
        @@current_id += 1
        @id = @@current_id
        @hp = hp
        @ap = ap
    end

    def self.print_current_id
        puts @@current_id
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

knight1 = Knight.new(15, 3)
Knight.print_current_id
knight2 = Knight.new(10, 5)
Knight.print_current_id
knight1.apply_damage 8
knight2.apply_damage 12
puts Knight::Max_Hp
puts Knight::Max_Ap

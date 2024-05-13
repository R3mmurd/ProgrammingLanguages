# Programming Languages
# Lecture 07: Classes and Objects

class Knight
    def introduce
        puts "Hello, I am a Knight!"
    end

    def apply_damage dam
        current_hp = 10

        if dam >= current_hp
            current_hp = 0
            puts "I am dead!"
        else
            current_hp -= dam
            puts "I am still alive, I have " + current_hp.to_s + " hp"
        end
    end
end

knight = Knight.new
knight.introduce
knight.apply_damage 8
knight.apply_damage 12
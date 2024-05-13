# Programming Languages
# Lecture 07: Getters and setters

class Knight

    attr_reader :id, :hp, :ap

    @@current_id = 0

    Max_Hp = 50
    Max_Ap = 20

    def initialize(hp, ap)
        @@current_id += 1
        @id = @@current_id
        @hp = hp
        @ap = ap
    end

    def self.current_id
        @@current_id
    end

    def to_s
        ans = "Knight: id = " + @id.to_s + " hp = " + @hp.to_s + ", ap = " + @ap.to_s

        if self.dead?
            ans += " (DEAD)"
        end

        ans
    end

    def dead?
        @hp <= 0
    end

    def apply_damage dam
        if @ap == 0
            @hp -= dam
        elsif dam > @ap
            new_dam = dam - @ap
            @ap = 0
            self.apply_damage new_dam
        else
            @ap -= dam
        end
    end
end

knight1 = Knight.new(15, 3)
puts knight1
knight2 = Knight.new(3, 5)
puts knight2
knight1.apply_damage 8
puts knight1
knight2.apply_damage 12
puts knight2
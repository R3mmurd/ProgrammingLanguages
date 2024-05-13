(* Programming Languages *)
(* Lecture 06: Namespace management *)

structure MyMathLib =
struct
    fun fact x =
        let
            fun helper acc x =
                if x = 0
                then acc
                else helper (acc * x)  (x - 1) 
        in
            helper 1 x
        end
    
    val half_pi = Math.pi / 2.0

    fun doubler y = y + y
end

val pi = MyMathLib.half_pi + MyMathLib.half_pi

val twenty_eight = MyMathLib.doubler 14

val fact5 = MyMathLib.fact 5 
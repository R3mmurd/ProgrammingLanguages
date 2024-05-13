(* Programming Languages *)
(* Lecture 06: A module example *)

structure Rational =
struct
    (* Invariant 1: all denominators > 0 *)
    (* Invariant 2: rationals kept in reduced form *)

    datatype rational = Whole of int | Frac of int * int
    exception BadFrac

    (* gcd and reduce help keep fractions reduced, 
       but clients need not know about them *)
    (* they _assume_ their inputs are not negative *)
    fun gcd x y =
        if x = y
        then x
        else if x < y
             then gcd x (y - x)
             else gcd y x
    
    fun reduce r =
        case r of
            Whole x => r
            | Frac (x, y) =>
                if x = 0
                then Whole 0
                else let
                        val d = gcd (abs x) y (* Using invariant 1 *)
                     in
                        if d = y
                        then Whole (x div y)
                        else Frac (x div d, y div d)
                     end

    (* when making a rational, we ban zero denominators *)
    fun make x y =
        if y = 0
        then raise BadFrac
        else if y < 0
                then reduce (Frac(~x, ~y))
                else reduce (Frac(x, y))
    
    (* using math properties, both invariants hold of the result
       assuming they hold of the arguments *)
    fun add r1 r2 =
        case (r1, r2) of
            (Whole i1, Whole i2) => Whole (i1 + i2)
            | (Whole i, Frac(n, d)) => Frac (n + d * i, d)
            | (Frac(n, d), Whole i) => Frac (n + d * i, d)
            | (Frac(n1, d1), Frac(n2, d2)) => reduce (Frac (n1 * d2 + d1 * n2, d1 * d2))
    
    fun to_string r =
        case r of
            Whole i => Int.toString i
            | Frac(n, d) => (Int.toString n) ^ "/" ^ (Int.toString d)
end
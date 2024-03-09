(* Programming Languages *)
(* Lecture 06: Signatures for our module example *)

(* 
    This signature hides gcd and reduce.  
    That way clients cannot assume they exist or call them with unexpected inputs.
*)
signature RATIONAL_A = 
sig
    datatype rational = Frac of int * int | Whole of int
    exception BadFrac
    val make : int -> int -> rational
    val add : rational -> rational -> rational
    val to_string : rational -> string
end

(*
    The previous signature lets clients build any value of type rational they
    want by exposing the Frac and Whole constructors.
    This makes it impossible to maintain invariants about rationals, so we
    might have negative denominators, which some functions do not handle, 
    and to_string may build a non-reduced fraction. 
    We fix this by making rational abstract.
*)
signature RATIONAL_B = 
sig
    type rational (* type now abstract *)
    exception BadFrac
    val make : int -> int -> rational
    val add : rational -> rational -> rational
    val to_string : rational -> string
end

(*
    As a cute trick, it is actually okay to expose the Whole function since
    no value breaks our invariants, and different implementations can still
    implement Whole differently.
*)
signature RATIONAL_C = 
sig
    type rational (* type now abstract *)
    exception BadFrac
    val Whole : int -> rational
    val make : int -> int -> rational
    val add : rational -> rational -> rational
    val to_string : rational -> string
end

(*
    This structure provides a small library for rational numbers -- same code as
    in previous example, but now we give it a signature
*)
structure Rational1 :> RATIONAL_A (* Or B or C *) =
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

(* An equivalent structure *)
structure Rational2 :> RATIONAL_A (* Or B or C *) =
struct
    (* This structure does not reduce ractions until printing *)

    datatype rational = Whole of int | Frac of int * int
    exception BadFrac

    (* when making a rational, we ban zero denominators *)
    fun make x y =
        if y = 0
        then raise BadFrac
        else if y < 0
             then Frac(~x, ~y)
             else Frac(x, y)
    
    (* using math properties, both invariants hold of the result
       assuming they hold of the arguments *)
    fun add r1 r2 =
        case (r1, r2) of
            (Whole i1, Whole i2) => Whole (i1 + i2)
            | (Whole i, Frac(n, d)) => Frac (n + d * i, d)
            | (Frac(n, d), Whole i) => Frac (n + d * i, d)
            | (Frac(n1, d1), Frac(n2, d2)) => Frac (n1 * d2 + d1 * n2, d1 * d2)
    
    fun to_string r =
        let
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
        in
            case reduce r of
                Whole i => Int.toString i
                | Frac(n, d) => (Int.toString n) ^ "/" ^ (Int.toString d)
        end
end

(* Another equivalent strcture *)
structure Rational3 :> RATIONAL_B =
struct
    (* Different abstract type, the signature RATIONAL_A cannot be used here *)
    type rational = int * int
    exception BadFrac

    fun Whole i = (i, 1)

    (* when making a rational, we ban zero denominators *)
    fun make x y =
        if y = 0
        then raise BadFrac
        else if y < 0
             then (~x, ~y)
             else (x, y)
    
    (* using math properties, both invariants hold of the result
       assuming they hold of the arguments *)
    fun add (n1, d1) (n2, d2) = (n1 * d2 + d1 * n2, d1 * d2)
    
    fun to_string (x, y) =
        let
            fun gcd x y =
                if x = y
                then x
                else if x < y
                     then gcd x (y - x)
                     else gcd y x
            
            val d = gcd x y
            val num = x div d
            val den = y div d
        in
            (Int.toString num) ^ (if den = 1 then "" else "/" ^ (Int.toString den))
        end
end

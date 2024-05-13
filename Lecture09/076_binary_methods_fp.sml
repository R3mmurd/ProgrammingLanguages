(* Programming Languages *)
(* Lecture 09: Binary Methods With Functional Decomposition *)

datatype exp = 
    Int    of int 
    | Negate of exp 
    | Add    of exp * exp 
    | Mult   of exp * exp
    | String of string
    | Rational of int * int

exception BadResult of string

fun add_values (v1, v2) =
    case (v1, v2) of
	    (Int i, Int j)                     => Int (i + j)
        | (Int i, Rational (j, k))         => Rational (i * k + j, k)
        | (String s, Int i)                => String(s ^ Int.toString i) (* not commutative *)
        | (String s1, String s2)           => String(s1 ^ s2)
        | (String s,  Rational(i, j))      => String(s ^ Int.toString i ^ "/" ^ Int.toString j)
        | (Rational _, Int _)              => add_values(v2, v1) (* commutative: avoid duplication *)
        | (Rational(i, j), String s)       => String(Int.toString i ^ "/" ^ Int.toString j ^ s)
        | (Rational(a, b), Rational(c, d)) => Rational(a * d + b * c, b * d)
        | _ => raise BadResult "non-values passed to add_values"

fun mult_values (v1, v2) =
    case (v1, v2) of
        (Int i, Int j)                     => Int (i * j)
        | (Int i, Rational (j, k))         => Rational (i * j, k)
        | (Rational _, Int _)              => mult_values (v2, v1) (* commutative: avoid duplication *)
        | (Rational(i, j), Rational(k, l)) => Rational(i * k, j * l)
        | _ => raise BadResult "non-values passed to mult_values"
        

fun eval e =
    case e of
        Int _ => e
        | Negate e1    => (case eval e1 of 
                               Int i => Int (~i)
                               | _ => raise BadResult "non-int in negation")
        | Add(e1, e2)  => add_values (eval e1, eval e2)
        | Mult(e1, e2) => mult_values(eval e1, eval e2)
        | String _     => e
        | Rational _   => e

fun to_string e =
    case e of
        Int i            => Int.toString i
        | Negate e1      => "-(" ^ (to_string e1) ^ ")"
        | Add(e1, e2)    => "("  ^ (to_string e1) ^ " + " ^ (to_string e2) ^ ")"
        | Mult(e1, e2)   => "("  ^ (to_string e1) ^ " * " ^ (to_string e2) ^ ")"
        | String s       => s
        | Rational(i, j) => Int.toString i ^ "/" ^ Int.toString j

fun has_zero e =
    case e of
	    Int i            => i = 0
        | Negate e1      => has_zero e1
        | Add(e1, e2)    => (has_zero e1) orelse (has_zero e2)
        | Mult(e1, e2)   => (has_zero e1) orelse (has_zero e2)
        | String _       => false
        | Rational(i, j) => i = 0

fun no_neg_constants e =
    case e of
        Int i            => if i < 0 then Negate (Int(~i)) else Int i
        | Negate e1      => Negate (no_neg_constants e1)
        | Add(e1, e2)    => Add (no_neg_constants e1, no_neg_constants e2)
        | Mult(e1, e2)   => Mult (no_neg_constants e1, no_neg_constants e2)
        | String _       => e
        | Rational(i, j) => if i < 0 andalso j < 0
                            then Rational(~i, ~j)
                            else if j < 0
                            then Negate(Rational(i, ~j))
                            else if i < 0
                            then Negate(Rational(~i, j))
                            else e

(* 5 + 10 * (-3) *)
val e = Add(Int 5, Mult(Int 10, Negate(Int 3)))
val _ = print ((to_string e) ^ " = " ^ (to_string (eval e)) ^ "\n")
(* 5 + 10 * (-3) *)
val e2 = no_neg_constants(Add(Int 5, Mult(Int 10, Int ~3)))
val _ = print ((to_string e) ^ " = " ^ (to_string (eval e)) ^ "\n")
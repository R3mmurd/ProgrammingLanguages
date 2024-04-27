(* Programming Languages *)
(* Lecture 09: Adding Operations or Variants *)

datatype exp = 
    Int    of int 
    | Negate of exp 
    | Add    of exp * exp 
    | Mult   of exp * exp

exception BadResult of string

(* this helper function is overkill here but will provide a more 
   direct contrast with more complicated examples soon *)
fun add_values (v1, v2) =
    case (v1, v2) of
	    (Int i, Int j) => Int (i + j)
        | _ => raise BadResult "non-values passed to add_values"

fun eval e =
    case e of
        Int _       => e
        | Negate e1 => (case eval e1 of 
                            Int i => Int (~i)
                            | _ => raise BadResult "non-int in negation")
        | Add(e1, e2)  => add_values (eval e1, eval e2)
        | Mult(e1, e2) => case (eval e1, eval e2) of
	                        (Int i, Int j) => Int (i * j)
                            | _ => raise BadResult "non-ints in multiply"

fun to_string e =
    case e of
        Int i       => Int.toString i
        | Negate e1   => "-(" ^ (to_string e1) ^ ")"
        | Add(e1, e2)  => "("  ^ (to_string e1) ^ " + " ^ (to_string e2) ^ ")"
        | Mult(e1, e2) => "("  ^ (to_string e1) ^ " * " ^ (to_string e2) ^ ")"

fun has_zero e =
    case e of
	    Int i       => i = 0 
        | Negate e1   => has_zero e1
        | Add(e1, e2)  => (has_zero e1) orelse (has_zero e2)
        | Mult(e1, e2) => (has_zero e1) orelse (has_zero e2)

fun no_neg_constants e =
    case e of
        Int i       => if i < 0 then Negate (Int(~i)) else Int i
        | Negate e1   => Negate (no_neg_constants e1)
        | Add(e1, e2)  => Add (no_neg_constants e1, no_neg_constants e2)
        | Mult(e1, e2) => Mult (no_neg_constants e1, no_neg_constants e2)

(* 5 + 10 * (-3) *)
val e = Add(Int 5, Mult(Int 10, Negate(Int 3)))
val _ = print ((to_string e) ^ " = " ^ (to_string (eval e)) ^ "\n")
(* 5 + 10 * (-3) *)
val e2 = no_neg_constants(Add(Int 5, Mult(Int 10, Int ~3)))
val _ = print ((to_string e) ^ " = " ^ (to_string (eval e)) ^ "\n")
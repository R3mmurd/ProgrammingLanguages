(* Programming Languages *)
(* Lecture 03: Useful Datatypes *)

datatype suit = Club | Diamond | Heart | Spade

datatype rank = Jack | Queen | King | Num of int

datatype id =
    StudentNum of int
    | StudentName of string * (string option) * string

datatype exp =
    Constant of int
    | Negate of exp
    | Add of exp * exp
    | Multiply of exp * exp

fun eval e =
    case e of
        Constant i         => i
        | Negate e1        => ~ (eval e1)
        | Add(e1, e2)      => (eval e1) + (eval e2)
        | Multiply(e1, e2) => (eval e1) * (eval e2)

fun number_of_adds e =
    case e of
        Constant i       => 0
      | Negate e1        => number_of_adds e1
      | Add(e1, e2)      => 1 + number_of_adds e1 + number_of_adds e2
      | Multiply(e1, e2) => number_of_adds e1 + number_of_adds e2

val example_exp = Add(Constant 19, Negate(Constant 4))

val example_ans = eval example_exp

val example_addcount = number_of_adds (Multiply(example_exp, example_exp))
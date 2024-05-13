(* Programming Languages *)
(* Lecture 06: Type inference *)

fun f x = (* infer val f : int -> int *)
    if x > 3
    then 24
    else x * 2

fun g x (* report type error *)
    if x > 3
    then true
    else x * 2
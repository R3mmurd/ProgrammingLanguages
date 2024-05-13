(* Programming Languages *)
(* Lecture 04: Returning functions *)

(* returning a function *)
fun double_or_triple f = (* double_or_triple : (int -> bool) - > (int -> int) *)
    if f 7
    then fn x => 2 * x
    else fn x => 3 * x

val double = double_or_triple (fn x => x - 3 = 4)
val eight = double 4

val nine = (double_or_triple (fn x => x = 42)) 3
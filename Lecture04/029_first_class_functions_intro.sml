(* Programming Languages *)
(* Lecture 04: Introduction to first-class functions *)

fun double x = 2 * x
fun incr x = x + 1
val a_tuple = (double, incr, double(incr 7))
val eighteen = (#1 a_tuple) 9
val ten = (#2 a_tuple) 9
val sixteen = #3 a_tuple
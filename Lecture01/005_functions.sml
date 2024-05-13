(* Programming Languages *)
(* Lecture 01: simple functions *)

(* This function only works properly for y >= 0 *)
fun pow(x : int, y : int) = (* int * int -> int *)
    if y = 0
    then 1
    else x * pow(x, y - 1)

fun cube(x : int) = pow(x, 3) (* int -> int *)

(* Optional parenthesis when function receives one argument *)
val sixtyfour = cube 4

val fortytwo = pow(2, 2 + 2) + pow(4, 2) + cube(2) + 2
(* Programming Languages *)
(* Lecture 01: pairs and tuples *)

(* pairs *)
fun swap(p : int * bool) = (* int * bool -> bool * int *)
    (#2 p, #1 p)

(* (int * int) * (int * int) -> int *)
fun sum_of_two_pairs(p1: int * int, p2 : int * int) =
    (#1 p1) + (#2 p1) + (#1 p2) + (#2 p2)

fun div_mod(x : int, y : int) =
    (x div y, x mod y)

fun sort_pair(p : int * int) =
    if (#1 p) < (#2 p)
    then p
    else (#2 p, #1 p)

(* nested pairs *)
val x1 = (7, (true, 9)) (* int * (bool * int) *)
val x2 = #1 (#2 x1) (* bool *)
val x3 = #2 x1  (* bool * int *)
val x4 = ((3, 5), ((4, 8), (0, 0))) (* (int * int) * ((int * int) * (int * int)) *)

(* tuples *)
val x5 = (1, true, "hello", 10) (* int * bool * string * int *)
val x6 = #1 x5 (* int *)
val x7 = #2 x5 (* bool *)
val x8 = #3 x5 (* string *)
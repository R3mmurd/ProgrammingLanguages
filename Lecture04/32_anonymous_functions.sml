(* Programming Languages *)
(* Lecture 04: Anonymous functions *)

fun n_times (n, f, x) =
    if n = 0
    then x
    else f (n_times(n - 1, f, x))

val x1 = n_times(5, fn x => x + 1, 2)
val x2 = n_times(5, fn x => x + x, 2)
val x3 = n_times(3, tl, [10, 20, 30, 40, 50])
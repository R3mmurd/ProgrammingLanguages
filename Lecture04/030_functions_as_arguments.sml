(* Programming Languages *)
(* Lecture 04: Functions as arguments *)

(* Three functions that execute n-times *)
fun increment_n_times (n, x) =
    if n = 0
    then x
    else 1 + increment_n_times (n - 1, x)

fun double_n_times (n, x) =
    if n = 0
    then x
    else 2 * double_n_times (n - 1, x)

fun nth_tail (n, xs) =
    if n = 0
    then xs
    else tl (nth_tail(n - 1, xs))

val seven1 = increment_n_times(5, 2)
val sixtyfour1 = double_n_times(5, 2)
val two_lastest1 = nth_tail(3, [10, 20, 30, 40, 50])

(* First-class function to execute another function n times *)
(* Computes f(f(...f(x))) where number of calls is n *)
fun n_times (n, f, x) =
    if n = 0
    then x
    else f(n_times(n - 1, f, x))

(* Shorter functions to replace the three functions above *)
fun increment x = x + 1
fun double x = 2 * x

val seven2 = n_times(5, increment, 2)
val sixtyfour2 = n_times(5, double, 2)
val two_lastest2 = n_times(3, tl, [10, 20, 30, 40, 50])
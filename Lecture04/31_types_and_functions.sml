(* Programming Languages *)
(* Lecture 04: Polymorphic types and functions as arguments *)

(* n_times function is polymorphic, it lets us use if for numbers, lists,
   or anything else provided f and x agree

   Return and argument type of f must be the same here because result is passed
   back to f
*)
fun n_times (n, f, x) = (* n_times: int * ('a -> 'a) * 'a -> 'a *)
    if n = 0
    then x
    else f (n_times(n - 1, f, x))

fun increment x = x + 1
fun double x = x + x

val x1 = n_times(5, increment, 2)             (* instantiates 'a with int *)
val x2 = n_times(5, double, 2)                (* instantiates 'a with int *)
val x3 = n_times(3, tl, [10, 20, 30, 40, 50]) (* instantiates 'a with int list *)

(* higher-order functions are often polymorphic based on whathever type
of function is passed, but not always *)
fun times_until_zero (f, x) = (* times_until_zero: (int -> int) * int -> int *)
    let
        fun acc(n, x) =
            if x = 0
            then n
            else acc(n + 1, f x)
    in
        acc(0, x)
    end

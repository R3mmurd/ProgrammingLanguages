(* Programming Languages *)
(* Lecture 04: Fold and more closures *)

(* Another hall-of-fame higher-order function *)

(* This perform "fold left" if order matters, can also do "fold right" *)
fun fold (f, acc, xs) =
    case xs of
        [] => acc
        | x::xs' => fold (f, f(acc, x), xs')

(* examples not using private data *)

fun sum_list xs = fold (fn (x, y) => x + y, 0, xs)

fun are_all_nonnegative xs = fold (fn (x, y) => x andalso y >= 0, true, xs)

(* example using private data *)
fun count_if_in_range (xs, lo, hi) =
    fold (fn (x, y) => x + (if y >= lo andalso y <= hi then 1 else 0), 0, xs)

fun are_all_strings_shorter_than (xs, s) =
    let
        val i = String.size s
    in
        fold (fn (x, y) => x andalso String.size y < i, true, xs)
    end

fun are_true_all_values (g, xs) = fold(fn (x, y) => x andalso g y, true, xs)

fun are_all_strings_shorter_than_again (xs, s) =
    let
        val i = String.size s
    in
        are_true_all_values(fn y => String.size y < i, xs)
    end

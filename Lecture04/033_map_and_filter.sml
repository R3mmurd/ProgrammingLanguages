(* Programming Languages *)
(* Lecture 04: Map and filter *)

fun map (f, xs) =
    case xs of
        [] => []
        | x::xs' => (f x)::map(f, xs')

val xs1 = map (fn x => x + 1, [10, 20, 30, 40, 50])
val xs2 = map (hd, [[1, 2], [3, 4], [5, 6, 7]])

fun filter (f, xs) =
    case xs of
        [] => []
        | x::xs' => if f x
                      then x::filter(f, xs')
                      else filter(f, xs')

val evens = filter (fn x => x mod 2 = 0, [1, 2, 3, 4, 5, 6, 7, 8, 9])
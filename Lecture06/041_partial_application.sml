(* Programming Languages *)
(* Lecture 06: Partial Application *)

fun sorted3 x y z = z >= y andalso y >= x

fun fold f acc xs = (* means fun fold f = fn acc => fn xs => *)
  case xs of
    []     => acc
  | x::xs' => fold f (f (acc , x)) xs'

(* If a curried function is applied to "too few" arguments, that just returns
   a closure, which is often useful -- a powerful idiom (no new semantics) *)
val is_nonnegative = sorted3 0 0

val sum = fold (fn (x, y) => x + y) 0

(* another example *)
fun range i j = if i > j then [] else i::range (i + 1) j

val countup = range 1

(* common style is to curry higher-order functions with function arguments
   first to enable convenient partial application *)
fun exists predicate xs =
    case xs of
        [] => false
        | x::xs' => predicate x orelse exists predicate xs'

fun no = exists (fn => x = 7) [4, 11, 23]

val has_zero = exists (fn x => x = 0)

val increment_all = List.map (fn x => x + 1)

val remove_zeros = List.filter (fn x => x <> 0)
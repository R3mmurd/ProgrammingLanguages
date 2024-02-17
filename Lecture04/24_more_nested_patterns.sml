(* Programming Languages *)
(* Lecture 03: More Nested Patterns *)

(* another elegant use of "deep" patterns *)
fun nondecreasing xs =
    case xs of
        [] => true
        | x::[] => true
        | head::(neck::rest) => (head <= neck andalso nondecreasing(neck::rest))

(* simpler use of wildcard pattern for when you do not need the data *)
fun len xs =
    case xs of
       [] => 0
      | _::xs' => 1 + len xs'
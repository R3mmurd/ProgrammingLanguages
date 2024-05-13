(* Programming Languages *)
(* Lecture 01: lists *)

val empty_list = [] (* 'a list *)

val xs = [1, 2, 3, 4, 5, 6] (* int list *)

val x = hd xs (* int --> 1 *)

val xs' = tl xs (* int list --> [2, 3, 4, 5, 6] *)

val is_empty1 = null empty_list (* bool --> true *)

val is_empty2 = null xs (* bool --> false *)
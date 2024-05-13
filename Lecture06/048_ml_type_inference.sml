(* Programming Languages *)
(* Lecture 06: ML type inference *)

val x = 24 (* val x : int *)

fun f (y, z, w) =
    if y       (* y must be bool *)
    then z + x (* z must be int *)
    else 0     (* both branches has the same type *)
(*
    f must return an int
    f must take a bool * int * anything
    So val f : bool * int * 'a -> int
*)
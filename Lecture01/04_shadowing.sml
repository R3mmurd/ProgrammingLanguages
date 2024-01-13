(* Programming Languages *)
(* Lecture 01: Examples to demonstrate shadowing *)

val a = 10
val b = a * 2
val a = 5
val c = b
val d = a
val a = a + 1
(* val g = f - 3 *) (* does not type-check *)
val d = a * 2
val f = 10
val f = "hello"
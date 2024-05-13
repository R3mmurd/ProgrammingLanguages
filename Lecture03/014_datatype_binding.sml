(* Programming Languages *)
(* Lecture 03: Datatype Binding *)

datatype mytype = TwoInts of int * int 
                | Str of string 
                | Pizza

val a = Str "hi"
val b = Str
val c = Pizza
val d = TwoInts(3 + 4, 5 + 4)
val e = a
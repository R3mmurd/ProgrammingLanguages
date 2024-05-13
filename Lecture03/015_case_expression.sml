(* Programming Languages *)
(* Lecture 03: Case Expression *)

datatype mytype = TwoInts of int * int 
                | Str of string 
                | Pizza

datatype my_boolean = True | False

fun f x =
    case x of 
        Pizza => 3 
        | Str s => String.size s
        | TwoInts(i1, i2) => i1 + i2
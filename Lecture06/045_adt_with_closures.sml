(* Programming Languages *)
(* Lecture 05: Abstract Data Types with closures *)

(* A set of integers with three operations *)
(* this interface is immutable -- insert returns a new version *)

(* Note: a 1-constuctor datatype is an SML trick for recursive types *)
datatype set = S of { 
    insert : int -> set,
    contains : int -> bool,
    size : unit -> int
}

val empty_set =
    let
        fun make_set xs = 
            let
                fun exists x = List.exists (fn y => x = y) xs
            in
                S { 
                    insert = fn x => if exists x
                                     then make_set xs
                                     else make_set (x::xs),
                    contains = exists,
                    size = fn () => length xs
                  }
            end
    in
        make_set []
    end

(* some tests *)
val S s1 = empty_set
val S s2 = #insert s1 24
val S s3 = #insert s2 24
val S s4 = #insert s3 12

(* all test val should be true *)
val test01 = (#contains s1 24) = false
val test02 = (#contains s1 12) = false
val test03 = (#size s1 ()) = 0
val test04 = (#contains s2 24)
val test05 = (#contains s2 12) = false
val test06 = (#size s2 ()) = 1
val test07 = (#contains s3 24)
val test08 = (#contains s3 12) = false
val test09 = (#size s3 ()) = 1
val test10 = (#contains s4 24)
val test11 = (#contains s4 12)
val test12 = (#size s4 ()) = 2

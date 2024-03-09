(* Programming Languages *)
(* Lecture 05: Abstract Data Types without closures *)

(* A set of integers with three operations *)
(* this interface is immutable -- insert returns a new version *)

datatype set = Cons of int * set | Empty

fun contains xs x =
    case xs of
        Empty => false
        | Cons (x', xs') => x' = x orelse contains xs' x

fun insert xs x = if contains xs x then xs else Cons (x, xs)

fun size xs =
    case xs of
        Empty => 0
        | Cons (x, xs') => 1 + size xs'


(* some tests *)
val s1 = Empty
val s2 = insert s1 24
val s3 = insert s2 24
val s4 = insert s3 12

(* all test val should be true *)
val test01 = (contains s1 24) = false
val test02 = (contains s1 12) = false
val test03 = (size s1) = 0
val test04 = (contains s2 24)
val test05 = (contains s2 12) = false
val test06 = (size s2) = 1
val test07 = (contains s3 24)
val test08 = (contains s3 12) = false
val test09 = (size s3) = 1
val test10 = (contains s4 24)
val test11 = (contains s4 12)
val test12 = (size s4) = 2

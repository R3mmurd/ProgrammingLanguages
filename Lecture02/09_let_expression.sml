(* Programming Languages *)
(* Lecture 02: Let Expression *)

fun dummy1(z : int) =
    let
        val x = if z > 0 then z else 24
        val y = x + z + 9
    in
        if x > y then x * 2 else y * y
    end

fun dummy2() =
    let
        val x = 1
    in
       (let val x = 2 in x + 1 end) + (let val y = x + 2 in y + 1 end)
    end

fun make_hello_world() = "Hello World!"

fun empty_function () = ()
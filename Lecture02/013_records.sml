(* Programming Languages *)
(* Lecture 02: Records *)

val x = {bar = (1 + 2, true andalso true), foo = 3 + 4, baz = (false, 9)}
(* val x : {bar: int * bool, foo: int, baz: bool * int} *)
(* val x = {bar = (3, true), foo = 7, baz = (false, 9)} *)

val my_favorite_singer = {name = "Simone", id = 41123 - 12}
(* val my_favorite_singer : {id: int, name: string} *)
(* val my_favorite_singer = {id = 41111, name = "Simone"} *)

val brain_part = {id = true, ego = false, superego = false}
(* val brain_part : {id: bool, ego: bool, superego: bool} *)
(* val brain_part = {id = true, ego = false, superego = false} *)
(* Programming Languages *)
(* Lecture 06: Callbacks *)

(* these two bindings would be internal (private) to the library *)
val cbs : (int -> unit) list ref = ref []
fun on_event e =
    let
        fun loop fs =
            case fs of
                [] => ()
                | f::fs' => (f e; loop fs')
        in
            loop (!cbs)
        end

(* clients call only this function (public interface to the library) *)
fun on_key_event f = cbs := f::(!cbs)

(* some clients where closures are essential
   notice different environments use bindings of different types
 *)
val times_pressed = ref 0
val _ = on_key_event (fn _ => times_pressed := (!times_pressed) + 1)

fun print_times_pressed () = print  (Int.toString (!times_pressed) ^ "\n");

fun print_if_pressed i =
    on_key_event (fn j => if i = j
                          then print ("you pressed " ^ Int.toString i ^ "\n")
                          else ())

val _ = print_if_pressed 4
val _ = print_if_pressed 11
val _ = print_if_pressed 23
val _ = print_if_pressed 4

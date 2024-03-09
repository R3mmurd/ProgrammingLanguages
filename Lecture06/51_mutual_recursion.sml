(* Programming Languages *)
(* Lecture 06: Mutual recursion *)

(* An example of mutual recursion: a little DFA for deciding if a list of ints
   alternates between 1 and 2, not ending with a 1. This example is simple,
   but any finite state machine can be programmed via a set of mutally recursive
   functions for the states.
*)

fun match xs =
    let
        fun s_need_one xs =
            case xs of
                [] => true
                | 1::xs' => s_need_two xs'
                | _ => false
        and s_need_two xs =
                case xs of
                    [] => false
                    | 2::xs' => s_need_one xs'
                    | _ => false
    in
        s_need_one xs
    end

(* Example to a lazy way to determine whether or not a number is even *)
fun is_even x =
    if x = 0
    then true
    else is_odd (x - 1)
and is_odd x =
    if x = 0
    then false
    else is_even (x - 1)

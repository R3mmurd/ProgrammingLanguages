(* Programming Languages *)
(* Lecture 06: Polymorphic examples *)

(*
    length : T1 -> T2 (must be a function; all functions take one argument)
    xs : T1 (must have type of length's argument)

    x : T3 (pattern-match against T3 list)
    xs' : T3 list (pattern-match against T3 list)

    T1 = T3 list (else pattern-match on xs doesn't type-check)

    0 : int
    So case expression : int
    So body : int
    So T2 = int

    recursive call type-checks because xs' has type T3 list, which = T1
    and T2 = int, so fine argument to addition

    So with all our constraints, length : T3 list -> int
    So length : 'a list -> int
*)
fun length xs =
    case xs of
        [] => 0
        | x::xs' => 1 + length xs'

(*
    f : T1 * T2 * T3 -> T4
    x : T1
    y : T2
    z : T3

    Both conditional branches must have type T4
    So T1 * T2 * T3 = T4 and T2 * T1 * T3 = T4, which means T1 = T2

    Putting it all together, f : T1 * T1 * T3 -> T1 * T1 * T3
    Now replace unconstrained types (consistently) with type variables
    f : 'a * 'a * 'b -> 'a * 'a * 'b
*)
fun f (x, y, z) =
    if true
    then (x, y, z)
    else (y, x, z)

(*
    compose = T1 * T2 -> T3
    f : T1
    g : T2
    x : T4

    from body of compose being a function, T3 = T4 -> T5
    from g being passed x, T2 = T4 -> T6
    from f being passed result of g, T1 = T6 -> T7
    from f being body of anonymous tunction T7 = T5

    Putting it all together: T1 = T6 -> T5, T2 = T4 -> T6, and T3 = T4 -> T5
    So compose (T6 -> T5) * (T4 * T6) -> (T4 -> T5)
    Now replace unconstrained types (consistently) with type variables
    compose : ('a -> 'b) * ('c * 'a) -> ('c -> 'b)
*)
fun compose (f, g) = fn x => f (g x)
(* Programming Languages *)
(* Lecture 05: Combining Functions *)

fun compose (f, g) = fn x => f (g x)

fun sqrt_of_abs_1 x = Math.sqrt(Real.fromInt (abs x))

fun sqrt_of_abs_2 x = (Math.sqrt o Real.fromInt o abs) x

val sqrt_of_abs_3 = Math.sqrt o Real.fromInt o abs

(* tells the parser !> is a function that appears between its two arguments *)
infix |>

(* definition of the pipeline operator *)
fun x |> f = f x

fun sqrt_of_abs_4 x = x |> abs |> Real.fromInt |> Math.sqrt

(* other compose functions *)
fun backup1 (f, g) = fn x => case f x of NONE => g x | SOME y => y

fun backup2 (f, g) = fn x => f x handle _ => g x
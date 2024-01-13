(* Programming Languages *)
(* Lecture 01: First ML program *)

(* val is a keyword
   x is a variable name
   = is used as a keyword here (has different meaning in expressions)
   24 is a very simple expression (and value)
   ; is used as a keyword here (has different meaning in expressions)
 *)
val x = 24;
(* static environment: x-->int *)
(* dynamic environment: x-->24 *)

val y = 12;
(* static environment: y-->int, x-->int *)
(* dynamic environment: y-->12, x-->24 *)

(* to evaluate an addition, evaluate the subexpressions and add *)
(* to evaluate a variable, lookup its value in the environment  *)

val z = (x + y) + (y + 2);
(* static environment: z-->int, y-->int, x-->int *)
(* dynamic environment: z-->50, y-->12, x-->24 *)

val q = z + 1;
(* static environment: q-->int, z-->int, y-->int, x-->int *)
(* dynamic environment: q-->51, z-->50, y-->12, x-->24 *)

val abs_of_z = if z < 0 then 0 - z else z;
(* static environment: abs_of_z-->int, q-->int, z-->int, y-->int, x-->int *)
(* dynamic environment: abs_of_z-->50, q-->51, z-->50, y-->12, x-->24 *)

val abs_of_z_simpler = abs z;
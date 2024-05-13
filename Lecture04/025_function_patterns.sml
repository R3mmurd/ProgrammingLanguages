(* Programming Languages *)
(* Lecture 03: Function Patterns *)

datatype exp = Constant of int 
             | Negate of exp 
             | Add of exp * exp
             | Multiply of exp * exp
            
fun eval (Constant i) = i
  | eval (Negate e1) = ~ (eval e1)
  | eval (Add(e1, e2)) = (eval e1) + (eval e2)
  | eval (Multiply(e1, e2)) = (eval e1) * (eval e2)

fun append ([], ys) = ys
  | append (x::xs', ys) = x::append(xs', ys)
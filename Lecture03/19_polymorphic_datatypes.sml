(* Programming Languages *)
(* Lecture 03: Polymorphic Datatypes *)

(* type is int list -> int *)
fun sum_list xs =
    case xs of
        [] => 0
        | x::xs' => x + sum_list xs'

(* type is 'a list * 'a list -> 'a list *)
fun append(xs, ys) =
    case xs of
        [] => ys
        | x::xs' => x :: append(xs', ys)

datatype 'a myoption = None | Some of 'a

datatype 'a mylist = Empty | Cons of 'a * 'a mylist

datatype 'a tree = EmptyTree | Node of 'a * 'a tree * 'a tree

fun sum_tree t =
    case t of
        EmptyTree => 0
        | Node(k, l, r) => k + sum_tree l + sum_tree r

fun num_nodes t =
    case t of
        EmptyTree => 0
        | Node(_, l, r) => 1 + num_nodes l + num_nodes r

fun height t =
    case t of
        EmptyTree => 0
        | Node(_, l, r) => let
                               val hl = height l
                               val hr = height r
                            in
                                if hl > hr
                                then hl
                                else hr
                            end

(* ('a tree * 'a * ('a * 'a) -> bool) -> 'a tree  *)
fun insert_in_bst(t, x, cmp) =
    case t of
        EmptyTree => Node(x, EmptyTree, EmptyTree)
        | Node(k, l, r) => if cmp(x, k)
                           then Node(k, insert_in_bst(l, x, cmp), r)
                           else
                               if cmp(k, x)
                               then Node(k, l, insert_in_bst(r, x, cmp))
                               else t

fun search_in_bst(t, x, cmp) =
    case t of
        EmptyTree => t
        | Node(k, l, r) => if cmp(x, k)
                           then search_in_bst(l, x, cmp)
                           else
                               if cmp(k, x)
                               then search_in_bst(r, x, cmp)
                               else t
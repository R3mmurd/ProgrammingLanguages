(* Programming Languages *)
(* Lecture 02: Nested Functions *)

fun countup(x : int) =
    let 
		fun count (from : int, to : int) =
			if from = to
			then to::[] (* note: we can also write [to] *)
			else from :: count(from + 1, to)
    in
	    count(1, x)
    end

fun countup_better (x : int) =
    let
		fun count (from : int) =
			if from = x
			then x::[]
			else from::count(from + 1)
    in
	    count 1
    end
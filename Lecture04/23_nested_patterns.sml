(* Programming Languages *)
(* Lecture 03: Nested Patterns *)

exception ListLengthMismatch

(* don't do this *)
fun shallow_zip3 (l1,l2,l3) =
    case l1 of
	    [] => (case l2 of 
                [] => (case l3 of
			            [] => []
		                | _ => raise ListLengthMismatch)
	            | _ => raise ListLengthMismatch)
        | hd1::tl1 => (case l2 of
	                    [] => raise ListLengthMismatch
	                    | hd2::tl2 => (case l3 of
			                            [] => raise ListLengthMismatch
			                            | hd3::tl3 => 
		(hd1, hd2, hd3)::shallow_zip3(tl1, tl2, tl3)))


(* do this *)
fun zip3 list_triple = (* (1, 2, 3) *)
    case list_triple of 
	    ([], [], []) => []
        | (hd1::tl1, hd2::tl2, hd3::tl3) => (hd1, hd2, hd3)::zip3(tl1, tl2, tl3)
        | _ => raise ListLengthMismatch

(* and the inverse *)
fun unzip3 lst =
    case lst of
		[] => ([], [], [])
      	| (a, b, c)::tl => 
        	let
				val (l1, l2, l3) = unzip3 tl
        	in
	            (a::l1, b::l2, c::l3)
			end
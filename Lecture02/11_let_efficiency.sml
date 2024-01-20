(* Programming Languages *)
(* Lecture 02: Let Efficiency *)

fun bad_max(xs : int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else if hd xs > bad_max(tl xs)
    then hd xs
    else bad_max(tl xs)

fun good_max(xs : int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else
        let 
            val tl_ans = good_max(tl xs)
        in
            if hd xs > tl_ans
            then hd xs
            else tl_ans
        end

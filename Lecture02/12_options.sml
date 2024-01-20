(* Programming Languages *)
(* Lecture 02: Options *)

fun better_max1(xs : int list) =
    if null xs
    then NONE
    else
        let
            val tl_ans = better_max1(tl xs)
        in
            if isSome tl_ans andalso valOf tl_ans > hd xs
            then tl_ans
            else SOME (hd xs)
        end
    
fun better_max2(xs : int list) =
    if null xs
    then NONE
    else let
        fun max_nonempty (xs : int list) =
            if null (tl xs)
            then hd xs
            else
                let 
                    val tl_ans = max_nonempty(tl xs)
                in
                    if hd xs > tl_ans
                    then hd xs
                    else tl_ans
                end
        in
            SOME (max_nonempty xs)
        end

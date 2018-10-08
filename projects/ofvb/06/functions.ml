let rec double l =
  match l with
  | [] -> []
  | h::t -> (h * 2) :: double t

let rec evens l =
  match l with
  | [] -> []
  | h::t -> (h mod 2 = 0) :: evens t

let rec map f l =
  match l with
  | [] -> []
  | h::t -> f h :: map f t

let halve x = x / 2

let is_even x = x mod 2 = 0

let evens l = map is_even l

let evens' l = map (fun x -> x mod 2 = 0) l

let rec merge cmp x y =
  match x, y with
  | [], l -> l
  | l, [] -> l
  | (hx::tx), (hy::ty) ->
      if cmp hx hy
        then hx::merge cmp tx (hy::ty)
        else hy::merge cmp (hx::tx) ty

let length l =
  let rec go x n =
    match x with
    | [] -> n
    | h::t -> go t (n + 1)
  in go l 0

let rec drop n l =
    match n, l with
    | 0, _    -> l
    | _, h::t -> drop (n - 1) t
    | _, []   -> []

let rec take n l =
    match n, l with
    | 0, _    -> []
    | _, h::t -> h :: take (n - 1) t
    | _, []   -> []

let rec msort cmp l =
  match l with
  | [] -> []
  | [x] -> [x]
  | _   -> let hl = length l / 2 in
           let a = take hl l in
           let b = drop hl l in
           merge cmp (msort cmp a) (msort cmp b)

let greater a b = a >= b

(* 1 *)
let calm = map (fun x -> if x = '!' then '.' else x)

(* 2 *)
let clip x = if x > 10 then 10 else (if x < 1 then 1 else x)
let clipList = map clip

(* 3 *)
let clipList' = map (fun x -> if x > 10 then 10 else (if x < 1 then 1 else x))

(* 4 *)
let rec apply f n x =
  match n with
  | 0 -> x
  | _ -> f (apply f (n - 1) x)

(* 5 *)
let rec sort cmp l =
  match l with
  | [] -> []
  | h::t -> insert cmp h (sort cmp t)
and insert cmp x l =
  match l with
  | [] -> x::[]
  | h::t -> if cmp x h then (x::h::t) else h::(insert cmp x t)

(* 6 *)
let rec filter f l =
  match l with
  | [] -> []
  | h::t -> if f h then h :: filter f t else filter f t

(* 7 *)
let rec foldl f b l =
  match l with
  | [] -> b
  | h::t -> foldl f (f b h) t

let for_all f l = foldl (fun x y -> x && f y) true l

(* 8 *)
let mapl f ll = map (map f) ll




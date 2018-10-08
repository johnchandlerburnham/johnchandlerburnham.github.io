let rec sort l =
  match l with
  | [] -> []
  | h::t -> insert h (sort t)
and insert x l =
  match l with
  | [] -> x::[]
  | h::t -> if x <= h then (x::h::t) else h::(insert x t)

let rec merge x y =
  match x, y with
  | [], l -> l
  | l, [] -> l
  | hx::tx, hy::ty ->
      if hx < hy then hx::merge tx (hy::ty) else hy::merge (hx::tx) ty

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

let length l =
  let rec go x n =
    match x with
    | [] -> n
    | h::t -> go t (n + 1)
  in go l 0

(* 1 *)
let rec msort l =
  match l with
  | [] -> []
  | [x] -> [x]
  | _   -> let halfLength = length l / 2 in
           let a = take halfLength l in
           let b = drop halfLength l in
           merge (msort a) (msort b)

(* 3 *)

let rec sort' l =
  match l with
  | [] -> []
  | h::t -> insert' h (sort' t)
and insert' x l =
  match l with
  | [] -> x::[]
  | h::t -> if x >= h then (x::h::t) else h::(insert' x t)

(* 4 *)

let rec isSorted cmp l =
  match l with
  | [] -> true
  | [x] -> true
  | x::y::t -> (cmp x y) && (isSorted cmp (y::t))

(* 6 *)
let rec sort'' l =
  let rec insert'' x l =
    match l with
    | [] -> x::[]
    | h::t -> if x <= h then (x::h::t) else h::(insert'' x t)
  in
  match l with
  | [] -> []
  | h::t -> insert'' h (sort'' t)

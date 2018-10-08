let rec take n l =
  match l, n with
  | [], 0 -> []
  | [], _ -> raise (Invalid_argument "take")
  | h::t, 0 -> []
  | h::t, n ->
      if n < 0 then raise (Invalid_argument "take") else h :: take (n - 1) t

let rec drop n l =
  match l, n with
  | [], 0 -> []
  | [], _ -> raise (Invalid_argument "drop")
  | h::t, 0 -> l
  | h::t, n ->
      if n < 0 then raise (Invalid_argument "drop") else drop (n - 1) t


exception Problem

exception NotPrime of int

let f x = if x < 0 then raise Problem else 100/x

let safe_divide x y =
  try x / y with
    Division_by_zero -> 0

let rec last l =
  match l with
  | [] -> raise Not_found
  | x::[] -> x
  | _::t -> last t

(* 1 *)
let rec sort cmp l =
  match l with
  | [] -> []
  | h::t -> insert cmp h (sort cmp t)
and insert cmp x l =
  match l with
  | [] -> x::[]
  | h::t -> if cmp x h then (x::h::t) else h::(insert cmp x t)

let rec filter f l =
  match l with
  | [] -> []
  | h::t -> if f h then h :: filter f t else filter f t

let smallest l = let ll = filter (fun x -> x > 0) (sort (<=) l) in
  match ll with
  | h::t -> h
  | _   -> raise Not_found

(* 2 *)
let smallest_or_zero l = try smallest l with 
  Not_found -> 0

(* 3 *)
exception NegativeArgument of int

let sqrt_floor n =
  let rec go n c = if c * c > n then (c - 1) else go n (c + 1)
  in if n < 0 then raise (NegativeArgument n) else go n 0

(* 4 *)
let safe_sqrt_floor n = try sqrt_floor n with
  (NegativeArgument x) -> 0




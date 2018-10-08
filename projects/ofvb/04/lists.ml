let isNils l =
  match l with
  | [] -> true
  | _  -> false

let rec length' l =
  match l with
  | [] -> 0
  | h::t -> 1 + length' t

let rec sum l =
  match l with
  | [] -> 0
  | h::t -> h + sum t

let length l =
  let rec go x n =
    match x with
    | [] -> n
    | h::t -> go t (n + 1)
  in go l 0

let rec odd_elements l =
  match l with
  | a::_::t -> a:: odd_elements t
  | _ -> l

let rec append a b =
  match a with
  | [] -> b
  | h::t -> h :: append t b

let rec rev l =
  match l with
  | [] -> []
  | h::t -> rev t @ [h]

(* 7 *)
let reverse l =
  let rec go xs ys =
    match xs with
    | [] -> ys
    | h::t -> go t (h::ys)
  in go l []

let rec take n l =
    match n with
    | 0 -> []
    | _ ->
      match l with
      | h::t -> h :: take (n - 1) t
      | [] -> []

let rec drop n l =
    match n with
    | 0 -> l
    | _ ->
      match l with
      | h::t -> drop (n - 1) t
      | [] -> []

(* 1 *)
let rec evens l =
  match l with
  | x::xx::xs -> xx :: evens xs
  | _ -> []

(* 2 *)
let count_true l =
  let rec go n l =
    match l with
    | x::xs -> if x then go (n+1) xs else go n xs
    | [] -> n
  in go 0 l

(* 3 *)
let buildPalindrome l = l @ (reverse l)

(* 4 *)
let rec drop_last l =
    match l with
    | [] -> []
    | x::[] -> []
    | x::xs -> x :: drop_last xs

(* 5 *)
let rec member x l =
  match l with
  | [] -> false
  | h::t -> if x = h then true else member x t

(* 6 *)
let make_set l =
  let rec go a b =
    match a with
    | x::xs -> if member x b then go xs b else go xs (x::b)
    | [] -> b
  in go l []

(* 7, see declaration of reverse *)


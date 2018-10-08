let fst (x, _) = x
let snd (_, x) = x

let rec lookup x l =
  match l with
  | [] -> raise Not_found
  | (k, v)::t ->
      if k = x then v else lookup x t

let rec add k v d =
  match d with
  | [] -> [(k,v)]
  | (k',v')::t -> if k = k' then (k,v)::t else (k',v')::add k v t

let rec remove k d =
  match d with
  | [] -> []
  | (k',v')::t -> if k = k' then t else (k',v')::remove k t

let rec key_exists k d =
  try
    let _ = lookup k d in true
  with
    Not_found -> false

(* 1 *)

let length l =
  let rec go x n =
    match x with
    | [] -> n
    | h::t -> go t (n + 1)
  in go l 0

(* 2 *)
let rec replace k v d =
  match d with
  | [] -> raise Not_found
  | (k',v')::t -> if k = k' then (k,v)::t else (k',v')::add k v t

(* 3 *)
let rec zip xs ys =
  match xs, ys with
  | x::tx, y::ty -> (x,y)::zip tx ty
  | [], []   -> []
  | _ , _    -> raise (Invalid_argument "mismatched lengths")

(* 4 *)
let unzip xs =
  let rec go bs p =
    match bs with
    | h::t -> go t (fst h :: fst p, snd h:: snd p)
    | [] -> p
  in go xs ([],[])

(* 5 *)
let rec add' k v d =
  match d with
  | [] -> [(k,v)]
  | (k',v')::t -> if k = k' then t else (k',v')::add' k v t

let makeDict ps =
  let rec go xs ys =
    match xs with
    | [] -> ys
    | h::t -> go t (add' (fst h) (snd h) ys)
  in go ps []

(* 6 *)

let rec union a b =
  match a with
  | [] -> []
  | h::t -> union t (add (fst h) (snd h) b)

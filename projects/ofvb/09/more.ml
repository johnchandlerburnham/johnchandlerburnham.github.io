
let rec map f l =
  match l with
  | [] -> []
  | h::t -> f h :: map f t

let mapl f l = map (map f) l

(* 2 *)
let rec foldl f b l =
  match l with
  | [] -> b
  | h::t -> foldl f (f b h) t

let rec member x l =
  match l with
  | [] -> false
  | h::t -> if x = h then true else member x t

let member_all x l = foldl (&&) true (map (member x) l)

(* 4 *)

let maplll f lll = map (map (map f)) lll

(* 5 *)
let rec take n l =
    match n, l with
    | 0, _    -> []
    | _, h::t -> h :: take (n - 1) t
    | _, []   -> []

let truncate n ll = map (take n) ll

(* 6 *)
let list_fst n ll =
  let head n l = match l with | h::t -> h | [] -> n
  in map (head n) ll




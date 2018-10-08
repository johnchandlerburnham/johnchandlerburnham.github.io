
type colour = Red | Green | Blue | Yellow | RGB of int * int * int

let col = Blue

let cols = [Red; Red; Green; Yellow]

let colpair = ('R', Red)

let components c =
  match c with
    Red -> (255,0,0)
  | Green -> (0,255,0)
  | Blue  -> (0,0,255)
  | Yellow -> (255,255,0)
  | RGB (r,g,b) -> (r,g,b)

type 'a option = None | Some of 'a

let rec lookup_opt x l =
  match l with
  | [] -> None
  | (k, v)::t -> if x = k then Some v else lookup_opt x t

type 'a seq = Nil | Cons of 'a * 'a seq


(* 1 *)

type rect = Rect of int * int

(* 2 *)
let area (Rect (w,h)) = w * h

(* 3 *)
let rotateThin (Rect (w,h)) = if w < h then Rect (w,h) else Rect (h,w)

(* 4 *)

let rec sort cmp l =
  match l with
  | [] -> []
  | h::t -> insert cmp h (sort cmp t)
and insert cmp x l =
  match l with
  | [] -> x::[]
  | h::t -> if cmp x h then (x::h::t) else h::(insert cmp x t)

let rec map f l =
  match l with
  | [] -> []
  | h::t -> f h :: map f t

let thinify l =
  sort (fun (Rect (x,y)) (Rect (x', y')) -> x < x') (map rotateThin l)

(* 5 *)
let rec dropSeq n l =
    match n, l with
    | 0, _    -> l
    | _, Cons (h, t) -> dropSeq (n - 1) t
    | _, Nil   -> Nil

let rec takeSeq n l =
    match n, l with
    | 0, _    -> Nil
    | _, Cons (h, t) -> Cons (h, takeSeq (n - 1) t)
    | _, Nil   -> Nil

let rec mapSeq f l =
  match l with
  | Nil -> Nil
  | Cons (h, t) -> Cons (f h, mapSeq f t)

(* 6 *)

type expr =
 | Num of int
 | Add of expr * expr
 | Subtract of expr * expr
 | Multiply of expr * expr
 | Divide of expr * expr
 | Power of expr * expr

let rec pow b e =
  match b, e with
  | 0, 0 -> 0
  | _, 0 -> 1
  | m, n -> m * pow b (e - 1)

let rec eval e =
  match e with
  | Num x -> x
  | Add (e,e') -> (+) (eval e) (eval e')
  | Subtract (e,e') -> (-) (eval e) (eval e')
  | Multiply (e,e') -> ( * ) (eval e) (eval e')
  | Divide (e,e') -> (/) (eval e) (eval e')
  | Power (e,e') -> pow (eval e) (eval e')

(* 7 *)
let rec safeEval e = try Some (eval e) with
  Division_by_zero -> None




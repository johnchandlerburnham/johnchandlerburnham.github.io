type 'a tree = Leaf | Branch of 'a * 'a tree * 'a tree

let rec size tr =
  match tr with
  | Branch (_, l, r)  -> 1 + size l + size r
  | Leaf -> 0

let rec map f tr =
  match tr with
  | Branch (a, l, r) -> Branch (f a, map f l, map f r)
  | Leaf -> Leaf

let rec foldMap f mempty tr =
  match tr with
  | Branch (a, l, r) -> f a (foldMap f mempty l) (foldMap f mempty r)
  | Leaf -> mempty

let max x y = if x > y then x else y

let maxDepth tr = foldMap (fun a x y -> 1 + max x y) 0 tr

let list_of_tree tr = foldMap (fun a x y -> x @ [a] @ y) [] tr

let rec lookup tr k =
  match tr with
  | Leaf -> None
  | Branch ((k',v),l,r) ->
      if k = k' then Some v
      else if k < k' then lookup l k
           else lookup r k

let rec insert tr k v =
  match tr with
  | Leaf -> Branch ((k, v), Leaf, Leaf)
  | Branch ((k',v'),l,r) ->
      if k = k' then Branch ((k,v),l,r)
      else if k < k' then Branch ((k', v'), insert l k v, r)
      else Branch ((k', v'), l, insert r k v)

(* 1 *)

let inTree k tr = match (lookup tr k) with
  | Some v -> true
  | None   -> false

(* 2 *)
let flipTree = foldMap (fun a l r -> Branch (a, r, l)) Leaf

(* 3 *)
let treeEq a b = (map (fun x -> 0) a) = (map (fun x -> 0) b)

(* 4 *)
let tree_of_list dict =
  let rec go xs tr = match xs with
  | [] -> tr
  | ((k,v)::t) -> go t (insert tr k v)
  in go dict Leaf

(* 5 *)
let tree_union x y =
  let rec go xs tr = match xs with
  | [] -> tr
  | ((k,v)::t) -> go t (insert tr k v)
  in go (list_of_tree x) y


(* 6 *)

type 'a polyTree = Leaf | Branch of 'a * 'a polyTree list

let rec mapl f l = match l with
  | h::t -> (f h)::(mapl f t)
  | []   -> []

let rec mapP f tr =
  match tr with
  | Branch (a, bs) -> Branch (f a, mapl (mapP f) bs)
  | Leaf -> Leaf

let rec foldr a f l = match l with
  | h::t -> f h (foldr a f t)
  | []   -> a

let rec foldMapP f mempty tr =
  match tr with
  | Branch (a, bs) -> foldr a f (mapl (foldMapP f mempty) bs)
  | Leaf -> mempty

let totalP = foldMapP (+) 0

let sizeP tr = totalP (mapP (fun x -> 1) tr)

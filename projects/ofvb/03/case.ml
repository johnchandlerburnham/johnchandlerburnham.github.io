let rec factorial a =
  match a with
  | 1 -> 1
  | _ -> a * factorial (a - 1)

let isVowel c =
  match c with
  | 'a' -> true
  | 'e' -> true
  | 'i' -> true
  | 'o' -> true
  | 'u' -> true
  | _   -> false


(* Questions *)

(* 1 *)
let not x =
  match x with
  | true  -> false
  | false -> true

(* 2 *)
let rec f2 n =
  match n with
  | 0 -> 0
  | _ -> n + f2 (n - 1)

(* 3 *)

let rec pow x n =
  match n with
  | 0 -> 1
  | _ -> x * pow x (n - 1)


(* 6 *)

let isLower c =
  match c with
  | 'a'..'z' -> true
  | _ -> false

let isUpper c =
  match c with
  | 'A'..'Z' -> true
  | _ -> false


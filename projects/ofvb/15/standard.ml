(* 1 *)

let rec concat a b = match a with
  | h::t -> h :: concat t b
  | [] -> b

(* 2 *)

let memsTrue l = List.for_all (List.mem true) l

(* 3 *)

let exclamations str = List.length (String.split_on_char '!' str) - 1

(* 4 *)
let replaceExclamations str =
  String.map (fun x -> if x = '!' then '.' else x) str

(* 5 *)

let concat = String.concat ""

(* 6 *)
let buffer_concat l =
  let t = Buffer.create 0 in
  List.iter (Buffer.add_string t) l;
  Buffer.contents t

(* 7 *)

let ocamls str = let subs = ref [] in
  for n = 0 to (String.length str) - 5 do
    subs := (String.sub str n 5) :: !subs;
  done;
  List.length (List.filter (fun x -> x) (List.map (String.equal "OCaml") !subs))




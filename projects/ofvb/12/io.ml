open String

let print_dict_entry (k,v) =
  print_int k;
  print_newline ();
  print_string v;
  print_newline ()

let rec print_dict d =
  match d with
  | [] -> ()
  | h::t -> print_dict_entry h; print_dict t

let rec iter f l =
  match l with
  | [] -> ()
  | h::t -> f h; iter f t

let print_dict' d = iter print_dict_entry d

(*
let rec read_dict () =
  let i = read_int () in
  if i = 0 then [] else
    let name = read_line () in
      (i, name) :: read_dict ()
*)

let rec read_dict () =
  try
    let i = read_int () in
    if i = 0 then []
    else
      let name = read_line () in
      (i, name) :: read_dict ()
  with
    Failure "int_of_string" ->
      print_string "This is not a valid integer. Please try again.";
      print_newline ();
      read_dict ()

let entry_to_channel ch (k, v) =
  output_string ch (string_of_int k);
  output_char ch '\n';
  output_string ch v;
  output_char ch '\n'

let dictionary_to_channel ch d =
  iter (entry_to_channel ch) d

let dictionary_to_file filename dict =
  let ch = open_out filename in
    dictionary_to_channel ch dict;
    close_out ch

let entry_of_channel ch =
  let number = input_line ch in
  let name   = input_line ch in
  (int_of_string number, name)

let rec dictionary_of_channel ch =
  try
    let e = entry_of_channel ch in
      e :: dictionary_of_channel ch
  with
    End_of_file -> []

let dictionary_of_file filename =
  let ch = open_in filename in
    let dict = dictionary_of_channel ch in
      close_in ch;
      dict

(* 1 *)
let print_int_list l =
  let rec go l =
    match l with
    | []   -> ()
    | h::[] -> print_int h; go []
    | h::t -> print_int h; print_string "; "; go t
  in print_string "["; go l; print_string "]"

(* 2 *)
let rec read_triple () =
  try
    let a = read_int () in
    let b = read_int () in
    let c = read_int () in
    (a,b,c)
  with
    Failure "int_of_string" ->
      print_string "This is not a valid integer. Please try again.";
      print_newline ();
      read_triple   ()

(* 3 *)
type ('a, 'e) result = Ok of 'a | Error of 'e

let rec read_dict' () =
  try
    let i = try Ok (print_string "Key? "; read_int ()) with e -> Error e in
    let name = try Ok (print_string "Value? "; read_line ()) with e -> Error e in
    match i, name with
    | Ok i', Ok n -> (i', n) :: read_dict' ()
    | Error x, _  -> raise x
    | _ , Error y -> raise y
  with
  | Failure "int_of_string" ->
      print_string "This is not a valid integer. Please try again.";
      print_newline ();
      read_dict' ()
  | _ -> []

(* 4 *)

let reverse l =
  let rec go xs ys =
    match xs with
    | [] -> ys
    | h::t -> go t (h::ys)
  in go l []

let rec map f l =
  match l with
  | [] -> []
  | h::t -> f h :: map f t

let range start stop step =
  let rec go a b s =
   if a >= b then []
   else a :: (go (a + s) b s)
  in go start stop step

let make_table_entry l= concat "\t" ((map string_of_int l) @ ["\n"])

let times_table n =
  let rec go a b =
  if a == n then []
  else (range a (b*a) a) :: (go (a + 1) b)
  in go 1 n;;

let output_times_table ch n =
  let tt = map make_table_entry (times_table n)
  in iter (output_string ch) tt

let times_table_to_file filename n =
  let ch = open_out filename in
  output_times_table ch n;
  close_out ch

(* 5 *)

let input_countlines ch =
  let rec go c ch =
    try
      let ln = try Ok (input_line ch) with e -> Error e
      in match ln with
      | Ok _ -> go (c + 1) ch
      | Error e -> raise e
    with
      End_of_file -> c
  in go 0 ch

let countlines filename =
  let ch = open_in filename in
  let n = input_countlines ch in
  close_in ch;
  n

(* 6 *)

let copy_ch ch_in ch_out =
  let rec go () =
    try
      let ln = try Ok (input_line ch_in) with e -> Error e
      in match ln with
      | Ok ln -> output_string ch_out ln; output_char ch_out '\n'; go ()
      | Error e -> raise e
    with
      End_of_file -> ()
  in go ()


let copyfile file_from file_to =
  let ch_in = open_in file_from in
  let ch_out = open_out file_to in
  copy_ch ch_in ch_out;
  close_in ch_in;
  close_out ch_out

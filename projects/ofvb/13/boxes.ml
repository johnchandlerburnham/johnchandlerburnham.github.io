let swap a b =
  let t = !a in
    a := !b; b := t

let smallest_pow2 x =
  let t = ref 1 in
    while !t < x do
      t := !t * 2
    done;
    !t

let print_histogram arr =
  print_string "Character frequencies:";
  print_newline ();
  for x = 0 to 255 do
    if arr.(x) > 0 then
      begin
        print_string "For character '";
        print_char (char_of_int x);
        print_string "'(character number ";
        print_int x;
        print_string ") the count is ";
        print_int arr.(x);
        print_string ".";
        print_newline ()
      end
    done

let channel_statistics in_channel =
  let lines = ref 0 in
  let characters = ref 0 in
  let words = ref 0 in
  let sentences = ref 0 in
  let histogram = Array.make 256 0 in
    try
      while true do
        let line = input_line in_channel in
          lines := !lines + 1;
          characters := !characters + String.length line;
          words := !words + (List.length (String.split_on_char ' ' line));
          String.iter
            begin
              fun c -> match c with
                | '.' | '?' | '!' -> sentences := !sentences + 1
                | _   -> ()
            end
            line;
          String.iter
            begin
              fun c -> let i = int_of_char c in
                histogram.(i) <- histogram.(i) + 1
            end
            line
        done
    with
      End_of_file ->
        print_string "There were ";
        print_int !lines;
        print_string " lines, making up ";
        print_int !characters;
        print_string " characters with ";
        print_int !words;
        print_string " words in ";
        print_int !sentences;
        print_string " sentences.";
        print_newline ();
        print_histogram histogram

let file_statistics name =
  let channel = open_in name in
    try
      channel_statistics channel;
      close_in channel
    with
      _ -> close_in channel

(* 2 *)
let twoRef = [ref 5; ref 5];;
let oneRef = let x = ref 5 in [x;x];;

let updateRefListHead l x = match l with
  | h :: t -> h := x; l
  | [] -> l

(* 5 *)

let sumArray arr =
  let sum = ref 0 in
  for x = 0 to (Array.length arr) - 1 do
    sum := !sum + arr.(x)
  done;
  !sum

(* 6 *)
let reverseArray arr =
  let len = Array.length arr in
  for x = 0 to (len / 2) - 1 do
    let ax = arr.(x) in
      arr.(x) <- arr.((len - 1) - x);
      arr.((len- 1) - x) <- ax;
    done;
  arr

(* 7 *)

let table n =
  let arr = Array.make_matrix n n 0 in
  for x = 0 to n - 1 do
    for y = 0 to n - 1 do
     arr.(y).(x) <- (x + 1)* (y + 1)
    done;
  done;
  arr

(* 8 *)
let toUpper c = match c with
  | 'a'..'z' -> char_of_int((int_of_char c) - 32)
  | _ -> c

let toLower c = match c with
  | 'A'..'Z' -> char_of_int((int_of_char c) + 32)
  | _ -> c




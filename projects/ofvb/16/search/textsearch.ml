let contains_substr substr str =
  let subs = ref [] in
  let sublen = String.length substr in
  for n = 0 to (String.length str) - sublen do
    subs := (String.sub str n sublen) :: !subs;
  done;
  (List.exists (String.equal substr) !subs)

let text_search str ch_in  =
  let rec go () =
    try
      let ln = try Ok (input_line ch_in) with e -> Error e
      in match ln with
      | Ok ln -> if (contains_substr str ln)
                  then (print_string ln; print_newline (); go ())
                  else go ()
      | Error e -> raise e
    with
      End_of_file -> ()
  in go ()

let text_search_file str file_from=
  let ch_in = open_in file_from in
  text_search str ch_in;
  close_in ch_in;

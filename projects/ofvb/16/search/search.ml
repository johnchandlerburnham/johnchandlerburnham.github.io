try
  begin match Sys.argv with
  | [|_; str; file2|] -> Textsearch.text_search_file str file2;
  | _ ->
      print_string "Usage: reverse <string> <file>";
      print_newline ();
  end
with
  e ->
    print_string "An error occurred: ";
    print_string (Printexc.to_string e);
    print_newline ();
    exit 1

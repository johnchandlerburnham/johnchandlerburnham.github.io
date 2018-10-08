try
  begin match Sys.argv with
  | [|_; file1; file2|] -> Textreverse.copy_reverse_file file1 file2;
  | _ ->
      print_string "Usage: reverse <file_from> <file_to>";
      print_newline ();
  end
with
  e ->
    print_string "An error occurred: ";
    print_string (Printexc.to_string e);
    print_newline ();
    exit 1

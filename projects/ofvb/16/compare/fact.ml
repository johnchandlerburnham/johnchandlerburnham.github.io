try
  begin match Sys.argv with
  | [|_; n|] -> print_string (Factorial.print_factorial (int_of_string n));
  | _ ->
      print_string "Usage: fact <number>";
      print_newline ();
  end
with
  e ->
    print_string "An error occurred: ";
    print_string (Printexc.to_string e);
    print_newline ();
    exit 1

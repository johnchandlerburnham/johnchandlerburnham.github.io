let copy_reverse_ch ch_in ch_out =
  let rec go () x =
    try
      let ln = try Ok (input_line ch_in) with e -> Error e
      in match ln with
      | Ok ln -> go () (ln :: x)
      | Error e -> raise e
    with
      End_of_file ->
        List.iter
          (fun ln -> output_string ch_out ln; output_char ch_out '\n';) x
  in go () []

let copy_reverse_file file_from file_to =
  let ch_in = open_in file_from in
  let ch_out = open_out file_to in
  copy_reverse_ch ch_in ch_out;
  close_in ch_in;
  close_out ch_out

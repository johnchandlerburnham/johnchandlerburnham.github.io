open Big_int

let rec factorial n = match n with
  | 0 -> (big_int_of_int 1)
  | _ -> mult_big_int (big_int_of_int n) (factorial (n - 1))

let print_factorial n = string_of_big_int (factorial n)

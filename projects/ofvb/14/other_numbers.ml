
let make_vector (x0, y0) (x1, y1) = (x1 -. x0, y1 -. y0)

let vector_length (x, y) = sqrt (x *. x +. y *. y)

let offset_point (x, y) (px, py) = (px +. x, py +. y)

let scale_to_length l (a, b) =
  let currentlength = vector_length (a, b) in
    if currentlength = 0. then (a, b) else
      let factor = l /. currentlength in
        (a *. factor, b *. factor)

(* 1 *)

let round x = let fx = floor x in
  if x -. fx < 0.5 then fx else fx +. 1.0

(* 2 *)
let euclidean_midpoint (x1,y1) (x2,y2) =
  ((x1 +. x2 ) /. 2.0, (y1 +. y2) /. 2.0)

(* 3 *)
let sep x = (floor x, x -. floor x)

(* 4 *)
let star x = let x' = if x > 1.0 then 1.0 else (if x < 0.0 then 0.0 else x) in
  let n = int_of_float (floor (50.0 *. x')) in
  let str = String.concat "" [String.make n ' '; "*\n"]
  in
  print_string str

(* 5 *)
let plot f lo hi step = let x = ref lo in
  while (!x <= hi) do
    star (f !x);
    x := !x +. step
  done

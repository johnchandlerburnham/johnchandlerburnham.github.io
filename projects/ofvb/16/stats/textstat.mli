(* Textstat module interface *)
type stats

val lines : stats -> int

val characters : stats -> int

val words : stats -> int

val sentences : stats -> int

val histogram : stats -> int array

val print_histogram : int array -> unit

val stats_from_file : string -> stats


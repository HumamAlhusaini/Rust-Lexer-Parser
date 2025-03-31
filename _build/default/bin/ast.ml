type identifier = string

type item =
  | Function of identifier * identifier * item list
  | MutableVar of identifier * int
  | ImmutableVar of identifier * int

type program = item list


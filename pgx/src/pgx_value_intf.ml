(** A wrapper for holding Postgres types *)
module type S = sig
  (** [v] is opaque because the exact contents depend on Postgres types, so you could have two [v]'s with the
      same value but different internal data representation, for example if you did a [SELECT 'a'::bytea] vs
      [SELECT 'a'::varchar], the internal representation will be different, but the actual data if you use
      [to_binary] or [to_string] will be the same. *)
  type v [@@deriving compare, sexp_of]

  type t = v option [@@deriving compare, sexp_of]

  exception Conversion_failure of string [@@deriving sexp_of]

  val required : ('a -> 'b) -> 'a option -> 'b
  val opt : ('a -> t) -> 'a option -> t
  val null : t
  val of_binary : string -> t
  val to_binary_exn : t -> string
  val to_binary : t -> string option
  val of_bool : bool -> t
  val to_bool_exn : t -> bool
  val to_bool : t -> bool option
  val of_float : float -> t
  val to_float_exn : t -> float
  val to_float : t -> float option

  type hstore = (string * string option) list [@@deriving compare, sexp_of]

  val of_hstore : hstore -> t
  val to_hstore_exn : t -> hstore
  val to_hstore : t -> hstore option

  type inet = Ipaddr.t * int [@@deriving compare, sexp_of]

  val of_inet : inet -> t
  val to_inet_exn : t -> inet
  val to_inet : t -> inet option
  val of_int : int -> t
  val to_int_exn : t -> int
  val to_int : t -> int option
  val of_int32 : int32 -> t
  val to_int32_exn : t -> int32
  val to_int32 : t -> int32 option
  val of_int64 : int64 -> t
  val to_int64_exn : t -> int64
  val to_int64 : t -> int64 option
  val of_list : t list -> t
  val to_list_exn : t -> t list
  val to_list : t -> t list option

  type point = float * float [@@deriving compare, sexp_of]

  val of_point : point -> t
  val to_point_exn : t -> point
  val to_point : t -> point option
  val of_string : string -> t
  val to_string_exn : t -> string
  val to_string : t -> string option
  val unit : t
  val to_unit_exn : t -> unit
  val to_unit : t -> unit option

  type uuid = Uuidm.t [@@deriving compare, sexp_of]

  val of_uuid : uuid -> t
  val to_uuid_exn : t -> uuid
  val to_uuid : t -> uuid option
end

(* -------------------------------------------------------------------------
   BitsN
   ------------------------------------------------------------------------- *)

signature BitsN =
sig
   (* Can/should be an abstract type when not using SMLExport
   eqtype nbit
   *)

   datatype nbit = B of (IntInf.int * Nat.nat)

   val BV: IntInf.int * Nat.nat -> nbit

   val allow_resize: bool ref

   val compare: nbit * nbit -> order
   val signedCompare: nbit * nbit -> order

   val fromBinString: string * Nat.nat -> nbit option
   val fromBit: bool -> nbit
   val fromBitstring: Bitstring.bitstring * Nat.nat -> nbit
   val fromBool: Nat.nat -> bool -> nbit
   val fromHexString: string * Nat.nat -> nbit option
   val fromInt: IntInf.int * Nat.nat -> nbit
   val fromNativeInt: int * int -> nbit
   val fromLit: string * IntInf.int -> nbit option
   val fromNat: Nat.nat * Nat.nat -> nbit
   val fromNatCheck: Nat.nat * Nat.nat -> nbit
   val fromString: string * Nat.nat -> nbit option

   val toBinString: nbit -> string
   val toBitstring: nbit -> Bitstring.bitstring
   val toHexString: nbit -> string
   val toInt: nbit -> IntInf.int
   val toNat: nbit -> Nat.nat
   val toString: nbit -> string
   val toUInt: nbit -> IntInf.int

   val #<< : nbit * Nat.nat -> nbit
   val #<<^ : nbit * nbit -> nbit
   val #>> : nbit * Nat.nat -> nbit
   val #>>^ : nbit * nbit -> nbit
   val && : nbit * nbit -> nbit
   val * : nbit * nbit -> nbit
   val + : nbit * nbit -> nbit
   val - : nbit * nbit -> nbit
   val < : nbit * nbit -> bool
   val <+ : nbit * nbit -> bool
   val << : nbit * Nat.nat -> nbit
   val <<^ : nbit * nbit -> nbit
   val <= : nbit * nbit -> bool
   val <=+ : nbit * nbit -> bool
   val > : nbit * nbit -> bool
   val >+ : nbit * nbit -> bool
   val >= : nbit * nbit -> bool
   val >=+ : nbit * nbit -> bool
   val >> : nbit * Nat.nat -> nbit
   val >>+ : nbit * Nat.nat -> nbit
   val >>+^ : nbit * nbit -> nbit
   val >>^ : nbit * nbit -> nbit
   val ?? : nbit * nbit -> nbit
   val @@ : nbit * nbit -> nbit
   val || : nbit * nbit -> nbit
   val ~ : nbit -> nbit
   val abs: nbit -> nbit
   val bit: nbit * Nat.nat -> bool
   val bitFieldInsert: Nat.nat * Nat.nat -> nbit * nbit -> nbit
   val bits: Nat.nat * Nat.nat -> nbit -> nbit
   val concat: nbit list -> nbit
   val div: nbit * nbit -> nbit
   val fromList: bool list -> nbit
   val log2: nbit -> nbit
   val lsb: nbit -> bool
   val max: nbit * nbit -> nbit
   val min: nbit * nbit -> nbit
   val mod: nbit * nbit -> nbit
   val msb: nbit -> bool
   val nativeSize: nbit -> int
   val neg: nbit -> nbit
   val one: Nat.nat -> nbit
   val quot: nbit * nbit -> nbit
   val rem: nbit * nbit -> nbit
   val replicate: nbit * Nat.nat -> nbit
   val resize: int -> nbit -> nbit
   val resize_replicate: int -> nbit * Nat.nat -> nbit
   val reverse: nbit -> nbit
   val sdiv: nbit * nbit -> nbit
   val signExtend: Nat.nat -> nbit -> nbit
   val size: nbit -> Nat.nat
   val smax: nbit * nbit -> nbit
   val smin: nbit * nbit -> nbit
   val smod: nbit * nbit -> nbit
   val tabulate: Nat.nat * (Nat.nat -> bool) -> nbit
   val toList: nbit -> bool list
   val zero: Nat.nat -> nbit
   val zeroExtend: Nat.nat -> nbit -> nbit
end

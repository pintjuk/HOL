signature bossLib =
sig

local
  type thm = Thm.thm
  type term = Term.term
  type hol_type = Type.hol_type
  type fixity = Parse.fixity
  type tactic = Abbrev.tactic
  type simpset = simpLib.simpset
  type 'a quotation = 'a Portable_General.frag list
in

  (* Define a datatype *)
  val Hol_datatype : hol_type quotation -> unit

  (* Make a definition  *)
  val Define  : term quotation -> thm
  val primDefine : term -> fixity -> string -> thm
  val Define_suffix : (string -> string) ref

  (* Fetch the rewrite rules for a type. *)
  val type_rws : string -> thm list

  (* Case-splitting and induction operations *)
  val Cases     : tactic
  val Induct    : tactic
  val Cases_on  : term quotation -> tactic
  val Induct_on : term quotation -> tactic
  val completeInduct_on : term quotation -> tactic
  val measureInduct_on : term quotation -> tactic

  (* Various basic automated reasoners *)
  (* First order *)
  val PROVE     : thm list -> term quotation -> thm
  val PROVE_TAC : thm list -> tactic

  (* cooperating decision procedures *)
  val DECIDE     : term quotation -> thm
  val DECIDE_TAC : tactic

  (* Simplification *)
  val empty_ss : simpset
  val bool_ss  : simpset
  val arith_ss : simpset
  val list_ss  : simpset
  val &&       : simpset * thm list -> simpset  (* infix && *)
  val RW_TAC   : simpset -> thm list -> tactic

  (* Compound automated reasoners. *)
  val STP_TAC  : simpset -> tactic -> tactic
  val ZAP_TAC  : simpset -> thm list -> tactic

  (* Support for proof by contradiction *)
  val SPOSE_NOT_THEN : (thm -> tactic) -> tactic

  (* Support for assertional-style proofs *)
  val by : term quotation * tactic -> tactic
end

end;

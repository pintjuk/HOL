structure Cache :> Cache =
struct

open HolKernel liteLib Trace Abbrev boolSyntax Rsyntax;

infix <<;  (* A subsetof B *)
fun x << y = all (C mem y) x;

type key = term list * term    (* Observation: seems term list is always [] *)
type data = (term list * thm option) list
type table = (key, data) Polyhash.hash_table
type cache = table ref;

local exception NOT_FOUND
      exception FIRST
      fun first p [] = raise FIRST
        | first p (h::t) = if p h then h else first p t
      fun new_table() = Polyhash.mkPolyTable (100,NOT_FOUND) : table
in
fun CACHE (filt,conv) =
  let val cache = ref (new_table()) : cache
      fun cache_proc thms tm =
        let val _ = if (filt tm) then ()
                    else failwith "CACHE_CCONV: not applicable"
            val prevs = Polyhash.find (!cache) ([],tm) handle NOT_FOUND => []
            val curr = flatten (map Thm.hyp thms)
            fun ok (prev,SOME thm) = prev << curr
              | ok (prev,NONE) = curr << prev
        in (case (snd (first ok prevs)) of
              SOME x => (trace(1,PRODUCE(tm,"cache hit!",x)); x)
            | NONE => failwith "cache hit was failure")
          handle FIRST =>
          let val thm = conv thms tm
              handle e as (HOL_ERR _)
                 => (trace(2,REDUCE("Inserting failed ctxt",
                           mk_imp{ant=list_mk_conj curr, conseq=tm}))
                     ;
                     Polyhash.insert (!cache) (([],tm),(curr,NONE)::prevs);
                     raise e)
          in (trace(2,PRODUCE(tm, "Inserting into cache:", thm));
              Polyhash.insert (!cache) (([],tm),(curr,SOME thm)::prevs); thm)
          end
        end;
  in (cache_proc, cache)
  end

fun clear_cache cache = (cache := new_table())

fun cache_values (ref cache) = Polyhash.listItems cache


end; (* local *)

end (* struct *)


(* Sequent Indexing

   A seq-index is a data structure for storing sequents with associated
   ids and values.  The structure supports 3 main operations:

   subsumes (t, seq) returns true iff there is a sequent in t that
   subsumes seq.

   subsumed (t, seq) returns the ids associated with the sequents in t that
   are subsumed by seq.

   matches (t, seq) returns the ids associated with the sequents in t that
   will match seq.
*)

signature Index = sig
   structure Id : Id
   type 'a t
   include Printable1 where type 'a printable1 = 'a t

   val create : unit -> 'a t
   val insert : 'a t * Id.t * Seq.t * 'a -> unit
   val remove : 'a t * Id.t -> unit
   val clear : 'a t -> unit
   val size : 'a t -> int
   val toList : 'a t -> 'a list
   val toListi : 'a t -> (Seq.t * 'a) list
   val find : 'a t * Id.t -> 'a option
   val findExn : 'a t * Id.t -> 'a
   val getSeq : 'a t * Id.t -> Seq.t
   val listSeqs : 'a t -> Seq.t list
   val member : 'a t * Id.t -> bool
   val isEmpty : 'a t -> bool

   (* forward subsumption *)
   val subsumes : 'a t * Seq.t -> bool

   (* backward subsumption *)
   val subsumed : 'a t * Seq.t -> Id.set

   val removeSubsumed : 'a t * Seq.t -> unit

   val insertRemoveSubsumed : 'a t * Id.t * Seq.t * 'a -> unit

   val undefinedCons : 'a t -> Id.set

   (* You must not update the underlying index during the fold. *)
   val fold : ((Seq.t * 'a) * 'b -> 'b) -> 'b -> 'a t -> 'b

   (* You must not update the underlying index during the app. *)
   val app : (Seq.t * 'a -> unit) -> 'a t -> unit

   (* Rule matching *)
   val matches : 'a t * Seq.t -> Id.set
end

comparing haskell kinds to f#, what is supported and what is missing?

what workaround is there for higher kinded types?

in dictionary passing, is the type in a tuple/dictionary with the first value/key representing the type constructor and the second value representing the ?

// HKT encoding: "F applied to T"
type App<'F, 'T> = private App of obj
// Example tags
type OptionTag = class end
type ListTag = class end
module HKT =
  let inline inj (x: 'Real) : App<'F,'T> = App (box x)
  let inline prj (App o) : 'Real = unbox o
type Functor<'F> =
  { Map : ('a -> 'b) -> App<'F,'a> -> App<'F,'b> }
// Instances
let optionFunctor =
  { Map =
      fun f fa ->
        let x : option<_> = HKT.prj fa
        HKT.inj (Option.map f x) }
let listFunctor =
  { Map =
      fun f fa ->
        let x : list<_> = HKT.prj fa
        HKT.inj (List.map f x) }
can you explain this snippet step by step?

can you explain the option "wrapping in interfaces"?

is it true that the wrapping using interfaces variant is close to object oriented programming and is not possible exactly like this in haskell?

are the HKT.inj and HKT.prj similar to haskells fmap?

are HKT.inj and HKT.prj replacing the usage of haskells fmap?
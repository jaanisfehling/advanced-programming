There is no equivalent to Haskells kind system in JavaScript right? Can you ropose patterns or abstractions in JavaScript (e.g. type-encoding with TypeScript or runtime conventions) that approximate kind-like reasoning? I was previously doing the same thing for F#, and was using 1) a generic type with two type variables, a witness and a element type and 2) a OOP style approach using interfaces (for example a functor interface requiring a map method)

In F# it was also possible to use interfaces for that kind of polymorphism. is it even correct?
Here is a code snippet that was give to me:
type IFunctor<'T> =
abstract Map<'U> : ('T -> 'U) -> IFunctor<'U>
type OptionF<'T>(x: option<'T>) =
member _.Value = x
interface IFunctor<'T> with
member .Map f = OptionF(Option.map f x) :> IFunctor<>
type ListF<'T>(x: list<'T>) =
member _.Value = x
interface IFunctor<'T> with
member .Map f = ListF(List.map f x) :> IFunctor<>

is it also possible to have such an approach in typescript?
# C10 - Kinds in Haskell and Their Analogues in F# and JavaScript
## Goal
Understand Haskell’s notion of kinds (the “types of type constructors”) and investigate to what extent similar ideas exist or can be emulated in F# and JavaScript, both at the language and library/design level.
## Tasks
1. Explain Haskell’s kind system (e.g. *, * -> *, higher-kinded types), showing examples with type constructors (Maybe, Either, []) and how the compiler uses kinds to type-check type-level code.
2. Discuss how F#’s type system relates to Haskell’s kinds (what is supported, what is missing, any workarounds for higher-kinded types), and propose patterns or abstractions in JavaScript (e.g. type-encoding with TypeScript or runtime conventions) that approximate kind-like reasoning.
3. Document the prompts you used with AI tools and describe how you checked the correctness of the explanations and code examples in all three ecosystems.

---
title: "Notes (LCBB 04/07): Reduction"
author: jcb
date: 2017-12-13
tags: workthrough, math, functional-programming, lambda-calculus
---

# 4 Reduction

## 4.1 Definition of compatible relations

- (i): A compatible relation between two lambda expressions `M` and `N` implies
  the same relation:
  *  between the application of `M` and `N` to another expression Z:
     ```
     M R N => (Z M) R (Z N)
     ```
  *  between the application of an expression `Z` to `M` and `N`
     ```
     M R N => (M Z) R (N Z)
     ```
  *  between an abstraction on `M` and `N`
     ```
     M R N => (\ x. M ) R (\ x. N)
     ```
- (ii): A congruence relation is a compatible equivalence relation. An
  equivalence relation is:
    * reflexive: `A R A`
    * symmetric: `A R B => B R A`
    * transitive: `A R B, B R C => A R C`
- (iii): A reduction relation is like a congruence without the symmetry
  constraint. In other words, it has a sense of directionality because the left
  hand side and right hand side of the relation are not interchangeable. This
  makes sense here because reducing a lambda expression is not the same thing
  as "un-reducing" it. That is, if we want to reverse a computation we need
  some extra information to know what the initial state was.


## 4.2 Definition of `->_β`, `->>_β` and `=_β`

- (i): Single-step Beta Reduction `->_β` or `->`:
  * `(\x. M) N -> M[x:= N]`
  * Single-step reduction is a compatible relation

- (ii): Any-step Beta Reduction (or just "β-reduction") `->>_β` or `->>`
  * `M ->> M` (reflexive)
  * `M -> N => M ->> N` (more general than `->`)
  * `M ->> N, N ->> L => M ->> L` (transitive)

- (iii): Equivalence `=_β` or `=`
  * `M ->> N => M = N` (more general than `->>`)
  * `M = N => N = M` (symmetric)
  * `M = N, N = L => M = L` (transitive)

## 4.3 Examples of `->`, `->>` and `=`

- (i): `ω = \ x. xx, Ω = ωω -> Ω`
- (ii): `KIΩ ->> I`

## 4.4 Example of `=`

```
KIΩ -> (\ y. I)Ω -> I
II -> I
KIΩ = I
```

So, equality, or β-convertibility, is like asking "do these two expressions
perform the same computation, i.e. return the same expressions for the same
inputs.

## 4.5 Proposition (equivalence of β-convertibility and λ-provable equality)

If you look at section 2.7, you'll see that λ-provable equality is a binary
relation that is:

*  reflexive
*  symmetric
*  transitive
*  compatible

Which is exactly the same structure as the β-convertibility relation. So if we
have a proof that `λ |- M = N`, we can convert each step into a proof that `M
=_β N` and vice-versa.

## 4.6 Definition of β-redex and β-normal form

- (i): A β-redex (reduction expression) is the application of a lambda
  abstraction to another expression:
  ```
  (\ x. M) N -> M[x:=N]
  ```
  The expression the redex reduces to is called the redex's contractum.

- (ii): A λ-term is a β-normal-form if it does not have a redex inside it as a
  subterm. In other words, if there are no further reductions that can be done
  on it (proved below in 4.8)

- (iii): A term has a normal form if it is convertible to a normal form.

## 4.8 Lemma

The triple line equals sign is confusing here, and is not disambiguated from
regular equals in the text. I think that triple line equals means
term-substitution, so this lemma is saying that if `M` is
β-reducible to `N`, then you can substitute any `N` for an `M`.

## 4.9 Church-Rosser Theorem

If `M` has two different reduction paths to distinct terms `N1` and `N2`, then
both of those terms will have reduction paths that converge on a third term
`N3`. In other words, it doesn't matter what order you reduce sub-terms of `M`,
because you'll always have a way to converge back to a common term. Even if you
have divergent terms in `M` like `Ω` and you can make infinite reductions
without converging, at every step you'll always have a way to come back to the
convergent path.

## 4.10 Corrolary

If `M = N`, then there is a common `L` to which they both reduce `M ->> L, N ->>
L`

There are only three cases where `M = N` (from the definition of `=_β` in 4.2).

1. `M ->> N => M = N`
2. `N = M  => M = N`
3. `M = N', N' = N => M = N`

An intuitive way to see that there are only three cases where `M = N` is by
looking at the diagram in the text and visualizing the arrows as a kind of fluid
flow, where `M = N` means that there is a waterway between `M` and `N`. If there
is a waterway, then either

`M` is downstream from `N`, `N ->> M`
`M` is upstream from `N` `M ->> N`
`M` is both upstream and downstream from `N`, `N ->> M && M ->> N`
`M` is neither upstream nor downstream from `N`

The first two cases can be thought of as the same, because `=` is symmetric.

Only the last case, where the waterway between `M` and `N` changes direction is
tricky and requires induction.

## 4.11 Corrolary

λ-terms are β-reducible to their normal forms, and have at most one such normal
form.

## 4.12 Some consequences

- (i): The λ-calculus is consistent. What about the Kleene-Rosser paradox or
  Curry's paradox?
- (ii): `Ω` has no normal form because it continually regenerates its redex.
- (iii): Once we reach a normal form there are no more redex's so reduction
  stop. We can get to this normal form by reducing the expression in any order
  that doesn't loop forever.

## 4.13 Definition of Underlining

- (i) Λ_ is almost exactly the same as the previous set of lambda expressions Λ from
  2.1. Compare the definition of Λ :
  ```
  x ∈ V        => x ∈ Λ
  M,N ∈ Λ      => (M N) ∈ Λ
  M ∈ Λ, x ∈ V => (\x.M) ∈ Λ
  ```

  with the definition of Λ_:

  ```
  x ∈ V           => x ∈ Λ_
  M,N ∈ Λ_        => (M N) ∈ Λ_
  M ∈ Λ_, x ∈ V   => (\ x.M) ∈ Λ_
  M,N ∈ Λ_, x ∈ V => ((\_ x.M) N) ∈ Λ_
  ```

  Almost exactly the same, with the exception of the last line, which introduces
  an underlined lambda abstraction (`\_`).

- (ii) The underlined reduction relations `->_` and and `->>_` are exactly like
  their non-underlined counterparts, but extended to deal with the `\_` lambda
  abstraction. They remove the underlining in a `\_` redex when they reduce it.

- (iii) The function `(\ M. |M|) : a ∈ Λ_ → a ∈ Λ` turns an underlined
  expression back into a regular one by dropping the underlinings. So if `M` is
  an underlined expression, `|M|` is a non-underlined one.

## 4.14 Definition of φ : Λ_ → Λ

```
φ(x) = x
φ(M N) = φ(M)φ(N)
φ(\x.M) = \x.φ(M)
φ((\_x.M)N) = φ(M)[x:= φ(N)]
```

Okay, so what's going on here is that `φ` is reducing all the underlined `\_`
redexes, but leaving the non-underlined ones `\ ` intact.

## 4.15 Lemma

This diagram is saying that in an underlined redex, dropping the underlines and
β-reducing is the same as `β_`-reducing and then dropping the underlines.
Remember that the `->>_` arrow (any-step `β_` reduction) treats underlined
lambda abstractions the same as non-underlined ones.

## 4.16 Lemma

- (i) This part of the lemma is saying that
  ```
  φ(sub_x(M,N)) = sub_x(φ(M),φ(N))
  ```
  that is, doing the substitution before the φ-reduction is the same as
  doing the φ-reduction before the substitution.
- (ii) This part is saying

## 4.17

## 4.18

## 4.19

## 4.20

## 4.21

## 4.22

## 4.23

## 4.24

## 4.25

## 4.26

## 4.27

## Exercises



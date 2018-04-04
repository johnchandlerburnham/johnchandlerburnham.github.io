---
title: "Workthrough: Intro to Lambda Calculus (Barendregt & Barendsen)"
author: jcb
date: 2017-12-13
tags: workthrough, math, haskell, functional-programming, lambda
---

**Work in progress**


# 1 Introduction

**The Entsheidungsproblem**: The decision problem. Loosely speaking,
is it possible to to come up with a general procedure to determine whether
statements are valid in some formal system. 

Take arithmetic as an example of a formal system. It has statements "1 + 1 =
2", "5 > 3" and so on. Some statements are true, like "1 + 1 = 2", while others
are false, like "1 = 0". Given an arbitrary statement `X`, is there a function
`D` such that `D(X)` returns True if `X` is true and False if `X` is false? 
That's the decision problem. And the answer is no. No such function exists,
nor can it exist.

**lambda calculus**: A formal system developed by Alonzo Church in 1936. Church
proved the decision problem in the negative by showing that no function exists
that can determine whether two expression in the lambda calculus were 
equivalent.

**Turing Machines**: A formal system developed by Alan Turing in 1936. Turing
proved the decision problem in the negative by showing that no function exists
that can determine whether a Turing machine will halt or run forever.

**Church-Turing Thesis**: The lambda calculus and Turing machines have 
equivalent power as formal systems. Any function defined in one can be 
defined in the other.

**Von Neumann Machines**: Turing machines with random access memory (RAM).
The usual formulation of a Turing machine has sequential access memory
on a tape. Most modern computers are hardware Von Neumann Machines.

Assembly languages and imperative programming languages are based on 
Turing machines, and are generally built around sequences of statements and
commands.

Functional programming languages are based on the lambda calculus and
are built around expression reduction. 

**Reduction Machine**: A machine designed to execute expressions in a
functional language. Such machines have been built in the flesh (in the silicon?),
such as the [Lisp Machines](https://en.wikipedia.org/wiki/Lisp_machine) but
are generally rare. Most functional programming languages compile to
Von Neumann Machine instructions.

## Reduction and functional programming

**functional program** An expression `E` that can be reduced. Reduction
of `E` is equivalent to computing the function that `E` represents. `E` is
reduced by some rewrite rules, such that a part `P` of E is replaced
with `P'`:

```
E[P] -> E[P']
```

as long as the replacement `P -> P'` is implied by the rewrite rules.

**Church-Rosser property**: If applying the rewrite rules in a reduction
system can be done in any order and yield the same expression, the reduction 
system satisfies the Church-Rosser property.

## Application and abstraction

**application**: A pair of expressions `F` and `A` where `F`
considered a function and `A` is the input to that function. 

**abstraction**: An expression parameterized on some variable. The
abstraction `\ x. M` can be considered the function from x to `M[x]`, 
where `M[x]` is the expression `M` containing some (or no) instances of 
`x.`

**Beta reduction**: When an abstraction is the first expression in an 
application:

```
(\x.M) N
```

then the application can be reduced by replaceing each instance of `x` in 
the expression `M` with `N`:

```
(\x.M) N = M[x := N]
```

## Free and bound variables

**binding a variable**: Every abstraction *binds* some variable. Variables can
be either *free* or *bound*. *Free* variables are those that are not *bound*
by any abstraction. When an abstraction is applied, only the variables
bound by that abstraction are substituted with the input. 

```
(\ x. y x (\ x. x)) N = y N (\ x. x)
```

The `x` in `\ x. x` is bound by inner `\ x.` abstraction head, not the outer
one. The expression `N` is only substituted for the variables bound by
the abstraction being applied, not those bound by any other.

## Functions of more arguments

**currying**: A construction of some function `f` that depends on multiple
arguments by the repeated application of functions of single arguments.
Suppose `f(x, y)` is a function that depends on both `x` and `y`. Then `f`
can be constructed from some function `F`, such that

```
F(x) = F_x
F_x(y) = f(x, y)
```

In the lambda calculus:

```
\ x.(F x) = F_x
\ y.(F_x y) = f(x, y)
```

So that,

```
(\ x. \ y. (F x) y) x y = (\ y. F_x y) y = f(x, y)
```

In other words, we transform `f` which mapped from the space of pairs `(x,y)`
to some output space, into the function `F` which maps from the space of `x`s
to the space of functions `F_x`, which are the functions that map from space of
`y`s to the output space.

In this way, we can build functions of multiple arguments out of chaining together
functions of single arguments.

# 2 Conversion

## 2.1 Definition of Lambda Terms

A lambda terms is either

  - A variable from the infinite set of variables

    ```
    V = {v, v', v'', ...}
    ```

  - An application `(M N)` where `M` and `N` are both lambda terms
  - An abstraction `(\ x M)`, where `x` is a variable and `M` is a lambda term

**Equivalent definition with de Bruijn indices:**

A lambda term is a natural number `{0, 1, 2, 3}` or any pair of lambda terms.

  - A variable is a natural number. 
  - An abstraction is any pair `(0 M)`, where `M` is a term.
  - All other terms are applications

## 2.2 Examples of Lambda Terms

Equivalent formulations:

```
v' = 2
v'v = 2 1
\ v ( v' v) = 0 (2 1)
((\ v (v' v)) v'')  = (0 (2 1)) 3
(((\ v (\ v' (v' v))) v'') v''') = (0 ((0 (1 2)) 3)) 4
```

Notice that we can remove the heads (decapitate) all abstractions by using
the variable number to indicate how may layers of abstraction the variable
is bound in. In the last line `0 (0 (1 2))` is equivalent to `\ x. \y. (y x)`.

De Bruijn indices are fun, but probably out of band for these notes. I
plan on doing more with them later though.

[TODO: Link future work on de Bruijn here]

## 2.3 Convention of Notation

1. Lower case letters are variables. Upper case letters are terms
2. `M == N` denotes that `M` and `N` are alpha equivalent. 
Two expressions are alpha equivalent if their Partial de Bruijn forms are identical.
An expression may be converted into its Partial de Bruijn form by replacing
every bound variable with the relative index of its binding abstraction layer,
every `\` followed by a variable with `0` and leaving all free variables constant.

```
(\ x y) z == (\ x y) z => (0 y) z 
(\ x x) z == (\ y y) z => (0 1) z 
(\ x x) z => (0 1) z \= z
(\ x x) z => (0 1) z \= (\ x y) z => (0 y) z
```

Hmm, this seems  awkward, but I find the defintion in the book
to be a little hand-wavy. Alpha equivalence can get really complicated
when we start to think about name shadowing etc. I really want to just
say that expressions are alpha equivalent if they're de Bruijn index forms
are equivalent, but I can't because even though free variables are free, but
they should be consistent in equivalent expressions.


[TODO: I'll come back to this with some more formal definition.]

3. Applications are left-associative:

```
F M1 M2 == (F M) M2
```

In an abstraction `.` separates the *head* variable
from the expression *body*

```
\ x1. (\ x2.  M) ==  \ x1 (\ x2 M)
```

Abstractions are right-associative, and 

```
\ x1. \ x2. M == \ x1. (\ x2.  M) ==  \ x1 (\ x2 M)
```

## 2.4 Definition of Free Variables

1. The set of free variables of an expression `M`, notated `freeVariables M`
are all indices in an expressions de Bruijn form which point to a relative
abstraction layer outside of `M.` Equivalently, they are the variables
that remain after converting `M` into it's Partial de Bruijn form.

2. `M` is a closed term or combinator if it has no free variables.

## 2.7 Definition of Lambda Calculus

1. The principle rewrite rule is beta reduction (defined above)

2. There are also logical rules:

    Equality:

    - All terms are equal to themselves
    - Equality is associative
    - Equality is transitive

    Compatibility rules:

    - Applications of equal terms to other equal terms are equal 
    - Abstractions of the same variable over equal terms are equal (eta conversion)

3. If a statement `S` is provable by these rules, we write `\ |- S` 


## 2.8 Remark on Alpha Conversion

I'm glad that the authors agree with me here that de Bruijn is the way to go. I
personally think its easier to learn de Bruijn indices first. Alpha conversion
is a *lot* more complicated than it seems the first time you learn it. But de
Bruijn hides no complexity, at the expense of being very tedious to reduce by
hand. But why are we reducing terms by hand? We live in the age of the 
computer!


## 2.10 SKI Combinators

Let

```
I  = \ x. x
K  = \ x y. x
K* = \ x y. y
S  = \ x y z. x z (y z) 
```

`I` is the identity function, `K` returns the first of two arguments, `K*` the
second of two arguments.

`S` is trickier. It takes three arguments, and applies the application of the
first to the third to the application of the second to the third. Think of
it as amalgamating all three values. 

Suppose we had the term `\ x. X F` and we wanted to apply `F` to `X`. Then
we could do:

```
S (\ x. K* x) (\ x. K x) (\ x. x X F) = 
(\ x. K* x) (\ x. x X F) ( (\ x. K) (\ x. x X F)) = 
(K* X F) (K X F) =
= F X 
```

## 2.12 Fixed-Point Combinator

Suppose `f` is a function. If there is an input `x` to `f` such that
`f(x) = x`, then `x` is said to be a *fixed-point* of `f`.

And let's also suppose we have a function `fix` that returns a fixed point `x` of a 
function, so that `fix(f) = x`.

Now we can do something neat! Let's look at the two above equations together:

```
f(x) = x
fix(f) = x
```

Because a fixed point `x` is the result of applying `f` to `x` *and* applying
`fix` to `f`:

```
fix(f) = f(x) = x
```

And we can expand this further

```
fix(f) = f(x) = f(fix(f)) = f(f(x))
```

So our `fix` function actually recursively applies `f`.

But can we build a lambda expression for `fix`. We can!

```
Y = \ f. (\ x. f (x x)) (\ x. f (x x))

Y F = (\ x. F (x x)) (\ x. F (x x)) =  F ((\ x. F (x x)) (\ x. F (x x))) 
  = F Y F
```

For a more intuitive explanation on how we might have invented the `Y` combinator
ourselves take a look at [my workthrough on Rojas'
Tutorial Introduction to the Lambda Calculus](http://localhost:8000/posts/workthrough-lambda-calculus-rojas.html#recursion).

## 2.13 Example

1. Simply:

```
Y F = F Y F => Y S = S Y S

G = Y S => G X = (Y S) X = S Y S X  = S G X
```

Which makes sense, because by eta conversion `(\ g x. S g x) = S`


2. If `G X = G G` then `G = \ x. G G`. This seems connected to (\ g x . g g)
in some way, but I'm not sure how to reason from one to the other...

Well, if using an expression that generates `Y` doesn't count as
using `Y` then:

```
G = (\ f. (\ x . x x) (\ x. f x x)) (\ g x. g g)
  = (\f . (\ x . f x x) (\ x. f x x)) (\ g x. g g) 
  = Y (\ g x. g g)
  = (\ g x. g g) (Y (\ g x. g g))
  = \ x. (Y (\ g x. g g)) (Y (\ g x. g g)) 
  = \ x. G G
```

But what if we can't even use an expression that generates `Y`?

Then we can just any another fixed point combinator. Let's try the `Z` combinator:


```
Z = \ f. (\ x. f (\ v. x x v)) (\ x. f (\ v. x x v))
```

Let's prove the `Z` combinator is a fixed point combinator by applying it to some
function `F` and showing that it satisfies `Z F = F (Z F)`

```
Z F = (\ f. (\ x. f (\ v. x x v)) (\ x. f (\ v. x x v))) F
    = (\ x. F (\ v. x x v)) (\ x. F (\ v. x x v))
    = F (\ v. (\ x. F (\ v. x x v)) 
              (\ x. F (\ v. x x v)) 
              v
        )
    = F (\ v. F (\ v. (\ x. F (\ v. x x v)) 
                      (\ x. F (\ v. x x v)) 
                      v   
                ) 
              v 
        )
    = F (\ v. (F (\ v. (\ x. F (\ v. x x v)) 
                      (\ x. F (\ v. x x v)) 
                      v   
                 ) 
              )
              v 
        )
```

Now this is a bit tricky, but remember that each entry of this is still equal
to `Z F`. We're going to use the third statement:

```
Z F = F (\ v. (\ x. F (\ v. x x v)) 
              (\ x. F (\ v. x x v)) 
              v
        )
```

To do a substitution in the last statement:
```
Z F  = F (\ v. ( F (\ v. (\ x. F (\ v. x x v)) 
                        (\ x. F (\ v. x x v)) 
                        v   
                  ) 
              )
              v 
        )
    = F ((\ v. Z F) v)
    = F (Z F) 
```

So `Z` is a fixed point combinator. Therefore,

```
G = Z (\ g x . g g) 
  = (\ g x . g g) (Z (\ g x . g g))
  = \ x. (Z (\ g x . g g)) (Z (\ g x . g g))
  = \ x. G G
```

Furthermore, this shows that for any fixed point combinator `fix`,
```
G = fix (\ g x . g g) => G X = G G
```

## 2.14 Definition of Numerals

1.  Let `F` be a lambda term, and `n` be a natural number. Then let us
    notated repeated application of `F` to `M` with
  
    ```
    F^0 M = M
    F^1 M = F M
    F^(n+1) M = F (F^n M)
    ```

2.  The Church numerals `C_0, C_1, C_2, ...` are defined by
  
    ```
    C_n = \ f x. f^n x
    ```

For an alternative presentation, see [2 Arithmetic, Workthrough: Tutorial
Intro to Lambda Calculus
(Rojas)](/posts/workthrough-lambda-calculus-rojas.html#arithmetic).

## 2.15 Definition of Arithmetic Operations

Let's prove that:

   ```
   add  = \ x y p q . x p (y p q);
   mult = \ x y z. x (y z)
   exp  = \ x y. y x
   ```

are expressions that perform addition, multiplication and exponentiation,
respectively.

### Addition

Okay, so a valid addition expresssion `add` will have the following property

```
add C_n C_m = C_(n + m) 
```

That is, the addition of two church numerals representing the natural numbers
`n` and `m` will be the church numeral representing their sum `n + m`

By the definition of church numerals:

```
C_(n + m) = \ f x . (f^(n + m) x)

\ f x. f^(n + 0) M) = \ f x . (f^(n) x)
\ f x. f^(n + 1) M) = \ f x . f (f^(n) x)
```

By induction on the defintion of the `^` notation:

```
\ f x. f^(n + 0) M) = \ f x . f^0 (f^n x)
\ f x. f^(n + 1) M) = \ f x . f^1 (f^n x)
\ f x. f^(n + 2) M) = \ f x . f^2 (f^n x)
...
\ f x. f^(n + m) M) = \ f x . f^m (f^n x)
```

Then if `add` is:

```
add  = \ m n f x . m f (n f x)

add C_m C_n = \ f x. (C_m f) (C_n f x)
            = \ f x. ((\ g x. g^m x) f) ((\ f x. f^n x) f x)
            = \ f x. (\ x. f^m x) (f^n x)
            = \ f x. f^m (f^n x)
            = \ f x.  (f^(n + m) x)
            = C_(n + m)
```

Q.E.D.

### Multiplication

A valid multiplication expression will have the following property:

```
mult C_n C_m = C_(n * m)
```

If `mult = \n m t. n (m t)`:

```
mult C_n C_m = (\n m t. n (m t)) (\ f x. f^n x) (\ f x. f^m x)
             = \ t. (\ f x. f^n x) ((\ f x. f^m x) t)
             = \ t. (\ f x. f^n x) (\ x. t^m x)
             = \ t. (\ f x. f^n x) (\ x. t^m x)
             = \ t. (\ x. (\ x. t^m x)^n x) 
```

By eta conversion `(\ x. F x) = F` and by the lemma 2.16, `(x^m)^n = x^(m*n)`

```
mult C_n C_m = \ t x. (t^m)^n x
             = \ t x. (t^(m * n)) x
             = C_(m * n)
```
             
### Exponentiation

A valid exponentiontial expression will have the following property:

```
exp C_n C_m = C_(n ^ m)
```

If `exp = \ x y. y x` then

```
exp C_n C_m = (\ x y. y x) C_n C_m 
            = C_m C_n 
            = (\ f x. f^m x) C_n
            = \ x. (C_n)^m x
            = \ x. C (n ^ m) x   [By lemma 2.16]
            = C (n ^ m)
```

## Exercises


**2.1**:

1. `M1 = v ( \ v' ((v' v'') (\ v''' (\ v'''' (v'' v''')))))`
2. `M2 = \ x y. (\ z. z) x y (y ((\ p. x p) y))`

**2.2**:

`M` and `N` are expressions with some number of free instances of `x` and `y` (maybe none,
maybe some). If we rewrite all instance of `x` in `M` with `N` then the free 
instances of `y` in `N` are now within `M[x:= N]`. If we further rewrite all instances of 
`y` in `M[x:= N]`, with `L` so as to obtain `M[x:= N][y:= L]` we will replace
every `y` in `M` with `L` and every `y` in every `N` in `L`.

Therefore,

```
M[x:=N][y:=L] = M[x:= N[y:=L]][y:=L]
```

Since there are no free instances of `x` in `L`, we can reorder the rewrites:

```
M[x:= N[y:= L]][y:= L] = M[y:= L] [x:= N[y:= L]]
```

**2.3**:

1. By the compatibility rules,

```
\ |- M1 = M2 => 
\ |- \x.M1 = \x.M2 => 
\ |- (\x.M1) N= (\x.M2) N => 
\ |- M1[x:= N] = M2[x:= N]
```

2. 

```
\ |- M1 = M2 => 
\ |- \x.M1 = \x.M2 =>
\ |- (\x.M1) N1 = (\x.M2) N1

\ |- (\x.M1) N1 = (\x.M2) N1 && \ |- N1 = N2 =>
\ |- (\x.M1) N1= (\x.M2) N2 => 
\ |- M1[x:= N1] = M2[x:= N2]
```

**2.4**:

See [Definition of Arithmetic Operations](/posts/workthrough-lambda-calculus-barendregt-barendsen.html#definition-of-arithmetic-operations)

**2.5**:

`N = X (Y Z)`

**2.6**:

1.  `(\x y z. z y x) a a (\p q. q) = (\p q. q) a a = a`

2.  ```
    (\y z. z y) ((\x. x x x) (\x. x x x)) (\w. I) = 
    (\w. I) ((\x. x x x) (\x. x x x)) =
    I
    ```

3. `SKSKSK = (\x y z. x z (y z)) K S K S K = (K K (S K)) S K = K S K = S`


**2.7**:

1. `KI = (\x y. x) (\ x . x) = \ y. \x . x = \ y x. x = K*`
2. `SKK = \ z. K z (K z) = \ z . z = I`

**2.8**:

1. `F = \x y. x (y x) y`
2. `F = \m n l. n (\x. m) (\y z. y l m)`

**2.9**:

1. `F = \x. x I`
2. `F = \x y. x I y`

**2.10**:

1. `K_n = Y K`
2. `F = Y (\x y. y x) => F x = (\ x y. y x) (Y (\x y. y x)) x = x F`
3.  ```
    F = Y (\ w x y z.  w K)  => 
    F I K K = (\ w x y z. w K) (Y (\w x y z. w K)) I K K
            = (Y (\x y z. w K)) K 
            = F K
    ```

**2.11**: 

I don't really understand what the comma in square brackets means, but I'll
try anyway.

For all expressions `C` (that are a function of some number of arguments),
there exists an expression `F` such that for all argument vectors `x~`, `F x~ =
C F x~`.

For any given C:

`F = Y (\ x. C x) = (Y (\x. C x)) = (\ x. C x) F = C F`

Which gives `F x~ = C F x~` via substitution.

**2.12**:

\y . (\ x y. y)

1. By defintion of `#`, `P # Q => \ + (P = Q) |- M = N` for all `M, N` in lambda,
   true and false are in lambda, therefore `P # Q => \ + (P = Q) |- true = false.`
   
   If,  \ + (P = Q) |- true = false, then for any `M, N` in lambda

   ```
   true = false => K = K* => K M = K* M => K M N => K* M N => M = N
   ```

   By definition, if `\ + (P = Q) |- M = N` for all `M, N` then `P # Q`. Therefore, 

   ```
   P # Q <=> \ + (P = Q) |- true = false
   ```



2. `I = K => I I = K I => I = K* => K = K*`
3.  ```
    F = (\p . (G p) y x)`
    G = (\g. g K g)
    G I = I K I = K I = K*
    G K = K K K = K

    F = \p. ((\g. g K g) p) y x

    F I = (\p. ((\g. g K g) p) y x) I 
        = ((\g. g K g) I) y x
        = (I K I) y x
        = (K I) y x
        =  K* y x
        = x

    F K = (\p .((\g. g K g) p) y x) K
        = ((\g. g K g) K) y x
        = (K K K) y x
        = K y x
        = y
    ```
   
4. `K = S => K K I = S K I => K = I => K = K*`

**2.13**:

```
<expression> := <name> | <abstraction> | <application>
<name> := v' | v'' | v''' | v''' | ...
<abstraction> := \ <name> <expression>
<application> := <expression> <expression>
```


# 3 The Power of Lambda


## 3.1 Definition of Booleans

1.  ```
    true = K
    false = K*
    ```

2.  ```
    if-then-else = (\i t e. i t e)
    ```

I think the pattern of using the "first" and "second" selector combinators
as booleans so that you can just use the truth-condition in an
"if-then-else" to directly select the right branch is really pretty somehow. 

## 3.2 Definition of Pairs

```
(M, N) = (\z. z M N)

(M, N) true = M
(M, N) false = N 
```

Of course, an "if-then-else" is inherently a pair: a pair of two code
branches that you switch between based on some condition. If you interpret
the branches as data branches rather than code branches, you get a really
nice representation of an ordered pair.

You can even use this pattern to construct any k-tuple. So a triple would 
be:

```
(T1, T2, T3) = (\z. z T1 T2 T3)
(T1, T2, T3) (choose-of 1 3) = T1 
(T1, T2, T3) (choose-of 2 3) = T2 
(T1, T2, T3) (choose-of 2 3) = T3
```

Where `choose-of i n` is an expression that gives you the `i`-th expression
of `n` expressions:

```
choose-of 0 1 = \x1. x1   = I
choose-of 0 2 = \x1 x2. x1 = K
choose-of 1 2 = \x1 x2. x2 = K*
choose-of 0 3 = \x1 x2 x3. x1
choose-of 1 3 = \x1 x2 x3. x2
choose-of 2 3 = \x1 x2 x3. x3
```

How might we implement "choose of"?

Let's start with an easier function `drop` which drops the first
`n` arguments:

Well, so first lets try to build a function that adds a 
layer of abstraction around any expression. So for any `M` we want:

```
(\x. M) = (\ m x . m) M = K M
```

Which is just the `K` combinator. Let's look at what happens if we apply the
`K` combinator multiple times:

```
K (K M) = K (\x. M) = (\x2. (\x1 . M)) = \x2 x1. M
K (K (K M)) = K (\x2. (\x1 . M))  = (\x3. (\x2. (\x1 . M)) = \x3 x2 x1. M
...
```

We can use the exponentiation notation from the last chapter to clean this
up:

```
K^0 M = M
K^1 M = K M
K^2 M = K (K M)
...
```

If we let `M` be the identity combinator, then we have
our `choose-n` function:

```
drop C_m = C_m K I

drop 0  = C_0 K I = I
drop 1  = C_1 K I = K I = K*
drop 2  = C_2 K I = K (K I) = (\x y z. z)
```

But if there are more than `n` arguments:

```
(T1, T2, T3) (drop 1) = (C_1 K I) T1 T2 T3 = K* T1 T2 T3 = T2 T3
```

So our `choose-of` function is going to need to get rid of a bunch of 
arguments that come after the one we want.

Let's define another function `first n` that returns the first of `n + 1`
arguments. 


```
first 0 = \ x1. x1
first 1 = \ x1 x2. x1
first 2 = \ x1 x2 x3. x1
...
```

By a similar construction to `drop`:

```
first C_n = \x . C_n K x
first 0 = \x . x
first 1 = \x . K x
first 2 = \x . K (K x)
...
```

Let's test this out:

```
(T1, T2, T3) (first 2) = (\x . K (K x)) T1 T2 T3
= K (K T1) T2 T3
= (K T1) T3
= T1
```

So our `choose-of` function will be:

```
choose-of = \ i n t. (first (sub n i)) (t (drop i))
```

Where `sub` is integer subtraction, whose derivation I'll leave for elsewhere.

[TODO: Subtraction]

Honestly, this construction of `n`-tuples seems ugly, and I'm not the biggest
fan of writing lambda expressions that are complicated enough to feel
like actual code. If I'm going to write code I want some actual tools...


## 3.3 Definition of natural numbers as pairs

```
0_ = I
(n + 1)_ = (false, n_)
```

So numbers can be defined as nested pairs.

## 3.4 Lemma: Successor, predecessor, isZero

```
succ n_ = (n + 1)_ = (false, n_) 
succ = (\n. (\p. p false n))

pred (n+1) = (\n. n false) (\p. p false n_)  = false false n_ = n_
pred = (\n. n false)

isZero = (\x . x true)
isZero 0 = (\x . x true) I = true
isZero 1 = (\x . x true) (\ p. p false n_) = true false n_ = false
```

## 3.5 Definition of lambda definability

**numeric function**: A function that maps numbers to numbers. If the
numeric function takes `p` arguments (which are numbers) it is calle `p`-ary

**lambda definable**: If there is a lambda expression that implements
a numeric function for all possible inputs, the function is said to
be lambda definable.

## 3.6 Definition of initial functions

- `U_i^n` is a projection function, given `n` arguments, it returns the `i`th
- `S` is successor.
- `Z` is the constant zero function.

If `P(n)` is a numeric relation, them `Mm[P(m)]` is the smallest (minimum)
number such that `P(m)` holds. If there is no such number `P(m)` is undefined.

## 3.7 Definition of closure


*Closure under composition*:

So `n` here is a vector: `[n_0, n_1, ..., n_k]`, where all `n_i` are numbers.

`psi_i` are functions on the same vector `n`, but I think this is equivalent
to having distinct vectors for each `psi` because we can use the projection 
function to select whatever elements of `n` we want.

So really, this is just that if a class is closed
function of numeric functions in that class is also a numeric function in
that class.

*Closure under primitive recursion:*

So if we have some series of functions where the base function and
the "next" function (which returns the next funciton in the
series) are both in a closed class, then all the functions in the series
are in the class.

*Closure under minimalization*:




## 3.17 Multiple Fixedpoint Theorem

Suppose we have two functions `F_1` and `F_2` and we want to find

```
X_1 = F_1 X_1 X_2
X_2 = F_2 X_1 X_2
```

Let `G` be `\ x. [ F_1 (x true) (x false), F_2 (x true) (x false)]`

Then by the fixed point combinator:

```
YG = G
YG = G(YG)
```

Substitituting,

```
YG = [ F_1 ((YG) true) ((YG) false), F_2 ((YG) true) ((YG) false)]
```

Let `X = YG`

```
X = [ F_1 (X true) (X false), F_2 (X true) (X false)]
```

Let `X_1 = (X true), X_2 = (X false)`

```
X = [ F_1 (X_1) (X_2), F_2 (X_1) (X_2)]
X true = F_1 (X_1) (X_2)
X false = F_2 (X_1) (X_2)]

X_1 = F_1 (X_1) (X_2)
X_2 = F_2 (X_1) (X_2)]
```

Notice that since `X_1 = X true` and `X_2 = X false`, `X` is equvalent
to `[X_1, X_2]`.

More usefully, for `F1, F2` we want a combinator `Y2` such that

```
Y2 F1 F2 = [X1, X2]
```

We can modify our `G` function from above:

```
G = \ x. [ F_1 (x true) (x false), F_2 (x true) (x false)]`

Y2 = \ f1 f2 . Y (\ x. [ f2 (x true) (x false), f2 (x true) (x false)])`
```

```
Y3 = \ f1 f2 f3. Y (\ x. [ f1 (x fst3) (x snd3) (x trd3)
                         , f2 (x fst3) (x snd3) (x trd3)
                         , f3 (x fst3) (x snd3) (x trd3)
                         ]
                   )
```


# 4 Reduction













   



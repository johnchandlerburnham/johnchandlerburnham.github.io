---
title: "Notes (LCBB 03/07): The Power of Lambda"
author: jcb
date: 2017-12-13
tags: workthrough, math, functional-programming, lambda-calculus
---

# 3 The Power of Lambda

## 3.1 Definition of Booleans

- (i):
  ```
  true  = K  = \x y. x
  false = K* = \x y. y
  ```

- (ii):
  ```
  if-then-else = (\i t e. i t e)
  ```

I think the pattern of using the "first" and "second" selector combinators
as booleans so that you can just use the truth-condition in an
"if-then-else" to directly select the right branch is really pretty.

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
choose-of 0 1 = \x1. x1    = I
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

Where `sub` is subtraction with Church numerals:

```
sub = \ x y. y pred x
```

`pred` is the predecessor or decrement function, which I explored in my notes on
[Tutorial Introduction to Lambda Calculus by Raul
Rojas](/notes/tilc/03.html#the-predecessor-function) for Church numerals, and is
defined below in section 3.4 for the nested pair encoding.

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

isZero = \x . x true
isZero 0 = (\x . x true) I = true
isZero 1 = (\x . x true) (\ p. p false n_) = true false n_ = false
```

## 3.5 Definition of Lambda Definability

- (i): This is just saying that a *numeric function* is a transformation or map
  from some (or no) numbers to one number. If we label the number of inputs as
  `p`, we can call the function a *`p`-ary* function. The *ary* in `p-ary` is a
  word pattern, called *arity* or sometimes *adicity*:

   | Inputs | Arity      | Adicity  | Function             |
   |--------|------------|----------|----------------------|
   | 0      | nullary    | nulladic | `f()`                |
   | 1      | unary      | monadic  | `f(a)`               |
   | 2      | binary     | dyadic   | `f(a,b)`             |
   | 3      | ternary    | triadic  | `f(a,b,c)`           |
   | 4      | quaternary | tetradic | `f(a,b,c,d)`         |
   | 5      | quinary    | pentadic | `f(a,b,c,d,e)`       |
   | >= 2   | multiary   | polyadic | `g(x_1,x_2,...,x_n)` |
   | n      | n-ary      | n-adic   | `g(..., x_n)`        |

  For example, a binary function, in this context, is one that takes two
  arguments.

  Note that the *arity* pattern uses the Latin roots (un-, bi-, ter-, ...) plus
  the *-ary* suffix, whereas the *adicity* pattern uses Greek roots (mon-, dy-,
  tri-,...) plus the *-adic* suffix. The *Adicity* words are almost always
  identical in meaning to their *Arity* counterparts. A common, but not
  universal convention is to use Latin words like *arity* to refer to values and
  Greek words like *adicity* to refer to types.

- (ii): A numeric function is called *λ-definable* if there is a lambda
  expression which computes the function.

## 3.6 Definition of initial functions

- The `U` functions are simply our `choose-of` functions from section 3.2. E.g.
  `U_2^4` is the same as `(choose-of 2 4)`, which returns the 2nd of 4
  arguments.
- `S` is the successor or increment function `succ`
- `Z` is the constant function `\ x. 0`
- The minimization function `μm[P(m)]` is tricky to understand, so lets work
  through it step by step:
  * `m` is a number
  * `P(m)` is predicate or true/false question on `m`: `"True or False: m is an
    even-number"` is an example of a predicate.
  * `μm[P(m)]` returns the smallest number for which the `P(m)` predicate is
    true. `μm["m is even"]` returns `2`, because `2` is the smallest even
    number.
  * If the predicate is always false though, like it would be for `"m
    is the square root of -1`" (since numeric functions only operate on natural
    numbers), then the minimization function is undefined.


## 3.7 Definition of a class of numeric functions

A class is a collection of objects that share some property. Class `A` is
a class of numeric functions where:

- (i): Any function built out of composing functions in `A` is a function in
  `A`. Composition in this case means chaining functions together by hooking up
  the output of one function to the inputs of another. E.g. the nested function
  `g(f(m)` is the same as `(g . f)(m)`, where `.` is the composition operator
  (for unary or curried functions).

- (ii): Primitive recursion means we start with a base case and then iterate
  through the natural numbers. `n^` is a vector of natural numbers (the initial
  state), `χ(n^)` is the base case, and `ψ` is the iterator function, which
  takes the current iteration `φ(k,n^)`, the counter `k` and the initial state
  `n^` as arguments.

  "`A` is closed under primitive recursion" means that any function we build by
  doing that kind of iteration with functions in `A` is still a function in `A`.

- (iii): Closure under minimization means that if we build a defined predicate
  out of a function in `A`, then the minimization function on that predicate is
  also in `A` (defined predicate means that there is some `m` for which the
  predicate is true.)

## 3.8 Definition of the class of recursive functions

The class of recursive functions is smallest possible class `A` that also has
the initial functions in it.

## 3.9 Lemma: The initial functions are λ-definable

see 3.6.

## 3.10 λ closure under composition

If `G, H1, .. Hm` are λ-expressions, and `x^` is some vector of variables, then

```
\ x^. G(H1 x^)... G(Hm x^)
```

is a lambda expression.

## 3.11 λ closure under primitive recursion

Basically the idea here is that we're building a lambda expression that executes
the primitive recursion calculation with a fixed-point combinator. It's a little
tedious, but looks really similar in mechanics to what I did above in 3.2 for
the `choose-of` function.

## 3.12 λ closure under minimization

Again, same basic concept of using a fixed point combinator to iterate through
all the natural numbers. Here we're building an expression to return the first
natural number that satisfies the predicate.

## 3.13 All recursive functions are λ definable

By definition, if λ-definable functions satisfy the above closures and contain
the initial functions, then they are a class of recursive functions. One
question this text doesn't really cover is whether the λ-definable functions are
the smallest possible class of recursive functions `R`. We not only need to show
that all functions in `R` are λ-definable, but also vice-versa.

## 3.14 λ-definability with respect to the Church numerals

If we can convert nested pair numerals to Church numerals and back, then we can
convert the above proof.

## 3.15 Numeral conversion

Let `C_n` be the `n`-th Church numeral, and `P_n` be the `n`-th Pair numeral:

```
churchToPair = \ x. x succ P_0
pairToChurch = \ x. if isZero x then C_0 else succ (pairToChurch (pred x))
```

## 3.17 Multiple Fixedpoint Theorem

Okay, so regular recursion with the fixed point theorem works like this:

```
Y F = X
    = F X
    = F (F X)
    = F (F (F X))
    = F (F (F (F X)))
    ...
```

Mutual recursion with the multiple fixed point works like this:

```
X1 = F1 X1 ... Xn
...
Xn = Fn X1 ... Xn
```

For `n = 2`:

```
X1 = F1 X1 X2
   = F1 (F1 X1 X2) (F2 X1 X2)
   = F1 (F1 (F1 X1 X2) (F2 X1 X2)) (F2 (F1 X1 X2) (F2 X1 X2))
   ...
X2 = F2 X1 X2
   = F2 (F1 X1 X2) (F2 X1 X2)
   = F2 (F1 (F1 X1 X2) (F2 X1 X2)) (F2 (F1 X1 X2) (F2 X1 X2))
   ....
```
Notice that the only difference between `X1` and `X2` above is outer application
of `F1` vs `F2` and the rest of the expressions are the same.

We can collapse mutual recursion to regular recursion by constructing a new
function `G` that has a single fixed point `X`:

```
G = \ x. [ F1 ((choose-of 1 2) x) ((choose-of 2 2) x)
         , F2 ((choose-of 1 2) x) ((choose-of 2 2) x)
         ]
```

where `choose-of` is the function that selects the `k`-th element of `n`
elements in a tuple according to our construction in section 3.2. To make `G`
more legible, lets label:

```
fst = choose 1 2
snd = choose 2 2

G = \ x. [ F1 (fst x) (snd x)
         , F2 (fst x) (snd x)
         ]
```

Now, let's find the fixed point of `G` with the `Y` combinator from section
2.12:

```
Y G = X
    = G X     = [ F1 (fst X) (snd X)
                , F2 (fst X) (snd X)
                ]
    = G (G X) = [ F1 (fst (G X) (snd (G X))
                , F2 (fst (G X) (snd (G X))
                ]
              = [ F1 (F1 (fst X) (snd X)) (F2 (fst X) (snd X))
                , F2 (F1 (fst X) (snd X)) (F2 (fst X) (snd X))
                ]
    ...
```

It might be kinda hard to see, but this is replicating the structure of

```
X1 = F1 X1 X2
   = F1 (F1 X1 X2) (F2 X1 X2)
   ...
X2 = F2 X1 X2
   = F2 (F1 X1 X2) (F2 X1 X2)
   ...
```

in a laborious way. Watch what happens if we say:

```
X1 = fst X
X2 = snd X
```

which collapses the big complicated `G (G X)` expression down into:

```
G (G X) = [ F1 (F1 X1 X2) (F2 X1 X2)
          , F2 (F1 X1 X2) (F2 X1 X2)
          ]
```

In other words, `X` is just containing and computing our two fixed-points `X1`
and `X2`:

```
X = [X1, X2]
```

Okay, so how does this generalize to `n` fixed points?

```
X1 = F1 X1                 ... Xn
   = F1 (F1 X1 ... Xn)     ... (Fn X1 ... Xn)
   = F1 (F1 (F1 X1 ... Xn) ... (Fn X1 ... Xn))
...
Xn = Fn X1                 ... Xn
   = Fn (F1 X1 ... Xn)     ... (Fn X1 ... Xn)
   = Fn (F1 (F1 X1 ... Xn) ... (Fn X1 ... Xn))
        ...
```

We can use the same tuple construction that we did with `n = 2`:

```
X = [X1, ... , X2]
G = \ x . [ F1 ((choose-of 1 n) x) ... ((choose-of n n) x)
          , ...
          , Fn ((choose-of 1 n) x) ... ((choose-of n n) x)
          ]
```

## Exercises

### 3.1

- (i):
  ```
  mult = \ n m t. (pairToChurch n) ((pairToChurch m) t)
  ```
- (ii):
  ```
  loop = \ test f next start. Y (\r s. test s ((f s) (r (next s)))) start
  fact = \ n . loop (\m. isZero m 1) mult pred n
  ```
  see [Notes: Tutorial Introduction to Lambda Calculus by Raul
  Rojas, *Division of positive integers recursively*](/notes/tilc/05.html#division-of-positive-integers-recursively)

### 3.2

```
ackermannGen = \ ack x y . isZero x (succ y)
                             (isZero y (ack (pred x) 1)
                               (ack (pred x) (ack x (pred y)))
                             )

ackermann = Y ackermannGen
```

Adapted from [Andrew Black's *Church's Lambda Calculus*
presentation](https://web.cecs.pdx.edu/~black/CS311/Lecture%20Notes/Lambda%20Calculus.pdf)


### 3.3

```
mGen = \ m x . isZero x ((m (succ x)) (m (pred x)))
m = Y mGen
M_n = m n
```


### 3.4
  see [Notes: Tutorial Introduction to Lambda Calculus by Raul
  Rojas, *The predecessor function*](/notes/tilc/03.html#the-predecessor-function)


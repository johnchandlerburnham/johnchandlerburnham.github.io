---
title: "Workthrough: A Tutorial Introduction to the Lambda Calculus (Rojas)"
author: jcb
date: 2017-11-14
tags: workthrough, math, haskell
---

**Work in progress**

This is a workthrough of a short paper introducing the Lambda Calculus by Raul
Rojas. A link to the paper is here:
[http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)

I found this paper as a follow-up resource listed in Chapter 1 of Haskell
Programming from First Principle by Chris Allen and Julie Moronuki, my
workthrough for which can be found here: [Workthrough: Haskell Programming From
First Principles, Allen & Moronuki](/posts/workthrough-hpfp.html)

Please note that I am using the `\` character to indicate &lambda;. This 
is partially so that my notation is closer to Haskell, and partially so I don't
have to write `&lambda` all the time in the Markdown file this page is being
generated from. In my first draft of these notes I actually wrote everything in
LaTex (using [MathJax](www.mathjax.org) to display it on the page). Despite how
great LaTex is (and MathJax!), this was a huge mistake as it proved to be
horrifically labor-intensive. So all the pseudocode on this page is
just going to be in ascii.

# 1 Definition

**Lambda Calculus**: The text says "the smallest universal programming 
language of [sic] the world [, consisting] of a single transformation rule
(variable substitution) and a single function definition scheme." I'm inferring
that by "smallest" the author means "simplest," but I would be interested to
see the claim that "lambda calculus is the simplest possible programming 
language" developed further. What does it mean for a programming language
to be "simple"? 

[NB. I will investigate this claim later and link back here]

Lamda Calculus consists of *expressions*:

**expression**: an expression is a *name*, a *function* or an *application*.
Any expression can be optionally surrounded by parentheses for clarity.

**name**: Also called a *variable*. Represents values, denoted
by single lettters: `

```
a, b, c ...
```

**function**: Also called an *abstraction*, Represents functions (in the
mathematical sense).  Notation is of the form 

```
\N. E
```

where `N` is a name and `E` is an expression. `N` is called the *head* and `E`
is called the *body* of the function.

**application**: Represents the concept of apply a function to an argument.
Notation is of the form 

```
F N
```

where `F` and `N` are expressions. Application
associates to the left, so 

```
F M N
``` 

is equivalent to 

```
((F M) N)
```

**evaluation**: In an application expresion `

```
F N
```

where `F` is a function, if the *name* in the head of `F` occurs anywhere in
the body of `F`, replace each occurence of that name with the expression `N`,
and return the body. 

Example: 

```
(\x. x) y
```

evaluates to simply `y`, and 

```
(\x. x y) y
``` 
evaluates to `y y`.

**the identity function**: 

```
id = \x. x
```
returns whatever it is applied to.

## 1.1 Free and bound variables

**bound variable**: The name in the head of a function is called a *bound*
variable, because the function binds it as a paramter.

**free variables**: Any names in the body of a function are not bound by the 
function and therefore are *free*.

The formal definition of free vs. bound in this text is confusing.  The
definition is overly detailed and obscures the idea of a function *binding* a
variable.

The principle is that a variable is bound if and only if it is in the body of a
function that *binds* it. Any variables not so bound are free. A variable
cannot be both bound and free in the scope of a single function, and we 
really only care about single functions, since we evaluate lambda expressions
one abstraction at a time.

The example given of `y` being both "bound" and "free" in 

    (\x. x y) (\y. y)

is right but misleading.  `y` is "free" in the
scope of the first function, but bound in the second.  Despite all appearences,
though, these are not the same `y`. 

`\y. y` is the identity function. So is `\x. x` or `\n. n`,
and any other expression of the same form which replaces the `y`'s with any
other letter. These are all equivalent ways to write the same function. And
therefore we can substitute any of them for any other. This property of not
caring which letters of the alphabet we use as long as the form is the same is
called alpha equivalence.

In the case of the example in the text, through alpha equivalence,

    (\x. x y) (\y. y) => (\x. x y) (\n. n)

And presto, `y` is not bound at all in this expression, according to the
definition given in the text.

The reason this is important is because scope matters. A statement might be
true at one scope and false in another, and if we're not careful to keep 
a clear idea of what scope we're operating at, we can start badly confusing
ourselves and others.

As an example, let's add an abstraction over `y` to the above:

    \y. (\x. x y) (\y. y)

Now `y` is not free in the expression at all. But we would be badly mistaken if
when we applied this abstraction to an expression `N` we did this:

    (\y. (\x. x y) (\y. y)) N => (\x. x N) (\y. N)

Again, the `y` in `(\y.y)` is not the same `y` as the one in the head
of the outer abstraction. Instead, we have to do this:

    (\y. (\x. x y) (\y. y)) N => (\x. x N)(\y. y)

Which makes sense, since

    (\x. x y)(\y. y) => (\x. x y)(\n. n)

**name-shadowing**: When, in nested abstractions, a variable in an inner
abstraction has the same name as a variable in an outer abstraction. 

## 1.2 Substitutions

The description of substitution in the text is a little haphazard, and I think
the formalism in the previous section would have been better served in this
one.

Here's what I would have included 
(see [Wikipedia](https://en.wikipedia.org/wiki/Lambda_calculus)):

**alpha equivalence**: Renaming the bound (formal) variables in the expression.
Used to avoid name collisions. Let `x` and `y` be names and let `M[x]` be an
expression `M` containing some `x` terms. Then in the following function,

    (\x.M[x]) => (\y.M[x:=y]) 

where `M[x:=y]` denotes replacing each instance of `x` in `M` with `y`.

**beta reduction**: Substituting the bound variable by the argument expression
in the body of the abstraction. Let `x` be a name and let `M` and `E` be 
expressions. Then in the following application,

    ((\x.M) E) => M[x:=E]

where `M[x:=E]` denotes replacing each instance of `x` in `M` with `E`.

Name shadowing can make both alpha equivalence and beta reduction more
complicated, so the above definitions only really apply without exception
when the variable names in all the lambda abstraction heads are different.

# 2 Arithmetic

Thus far, everything we've seen with lambda calculus has been a symbol
manipulation game, and not obviously meaningful. So we're going to put some
meaning into it by coming up with a way to do arithmetic. 

First, we're going to need numbers. Specifically, we're going to need to 
find a coherent way to represent the natural numbers 

```
0, 1, 2, 3, ...
```

as lambda expressions. The way we're going to do this is by implementing of
Peano numbers in lambda calculus. 

[N.B. I will find/write a good explanation of Peano numbers, link it
here, and rework this to be clearer]

First, we're going to pick an expression for `0`, which we'll call
`Zero`, and then a successor function `succ`, so that

```
0 = Zero
1 = succ Zero
2 = succ (succ Zero)
...
```

and so on. This is the standard Peano definition of the natural numbers. 

But there's a neat trick we can do in our lambda calculus implementation
of Peano numbers. Notice how the Peano numbers are defined as a zero and
then layers of a succesor function on top of zero. 
We know how to express functions in lambda calculus, so what if we rewrote
the above definition of Peano numbers as functions of two parameters `s` and
`z`, which will stand in for whatever expressions we pick for the successor
function and the zero, respectively. We'll call these lambda functions that
return numbers `n_`, where `n` is the number they return:

Let's start with `0_`. We know that all the `n_` functions are
functions of `s`, (`succ`) and `z` (`Zero`), so the
heads of all our `n_` will be the same: `\s z`.

For `0_` we throw away the successor and just return the zero:

```
0_ = \s z. z 
```

For `1_` we apply the succesor once:

```
1_ = \s z. s z 
```

For `2_` we apply the succesor twice:

```
2_ = \s z. s (s z) 
```

And so on, giving us the following functions:

```
0_ = \s z. z
1_ = \s z. s z
2_ = \s z. s (s z)
3_ = \s z. s (s (s z))
...
```

Now here's the trick. The above functions are already lambda expressions. So 
while we could find other expressions that would work as numbers, we can 
just use the above `n_` functions as numbers directly. 

If we do that then we already found an expression for our zero: `\sz.z`.
Which is just a function that throws away its argument and returns our old friend
the identity function.

One way to visualize this structure is to imagine `n_` as the set of functions
that apply another function to an argument `n` times. `Zero` is "apply zero
times" or "don't apply", one is "apply once", two is "apply twice" and so on.

Now we just need a `succ` function. `succ` takes a number and returns
that number plus one. But if our numbers are functions that apply another
function to an argument some number of times, then `succ` takes
a number `n`, a function `f` and an argument `x` then applies `f` to x
an `(n+1)` number of times. In other words, `succ` is like an "apply once
more"function. 

Here's what that function looks like:

    succ = \n f x. f (n f x)

Let's see what happens when we apply `succ` to a number:

```
succ 0_ = (\n f x. f (n f x)) (\s z. z) => 
\f x. f ((\s z.z) f x) =>
\f x. f x
```

Through alpha equivalence `\f x. f x` is the same as `\s z. s z`
which is `1_`.

Applying `succ` to `1_

```
succ 1_ = (\n f x. f (n f x)) (\s z. s z) => 
\fx. f ((\s z. s z) f x) =>
\f x. f (f x) =>
2_
```

## 2.1 Addition

Once we understand `succ`, `add` is pretty easy . Whereas `succ` is
"apply `f` to `x`, `n`-times", `add` is "apply `f` to `x`, `n`-times, then
`m`-times, for a total of `(n + m)` applications."

```
add = \m n f x. m f (n f x)
```

Let's see this in action:

```
add 1_ 2_ = (\n m f x. m f (n f x)) (\s z. s z) (\s z. s (s z)) => 
\f x. (\s z. s z) f ((\s z. s (s z)) f x) =>
\f x. (\z. f z) ((\s z. s (s z)) f x) => 
\f x. f (\s z. s (s z) f x) =>
\f x. f (f (f x)) => 
3_
```

A useful pattern we can notice is that `add` can also be expressed as:

```
add = \m n f x. m f (n f x) => \m n. \f x.  m f (n f x) =>
\m n. m (\f x. n f x) => \m n. m (\n f x. n f x) n =>
\m n. m succ n
```

This might seem less mysterious if we do the equivalence in reverse.

```
\m n. m succ n => \m n. m (\n f x. f (n f x)) n => 
\m n. m (\f x. f (n f x)) => \m n. \f x. m f (n f x) => 
\m n f x. m f (n f x)
=> add
```

## 2.2 Multiplication

`multiply` is even easier, we just feed one number into another:

```
multiply n m = \n m t. n (m t)
```

If we multiply `2_` by `2_`:

```
multiply 2_ 2_ =>
(\n m t. n (m t)) (\s z.s (s z)) (\s z. s (s z)) =>
\t. (\s z. s (s z)) (\s z. s (s z) t) =>
\t. (\s z. s (s z)) (\z. t (t z)) =>
\t. \z. (\z. t (t z)) ((\z. t (t z)) z) =>
\t z. (\z. t (t z)) ((\z. t (t z)) z) =>
\t z. (\z. t (t z)) (t (t z)) =>
\t z. t (t (t (t z))) =>
\s z. s (s (s (s z))) =>
 4_
```

Okay, maybe that was a little tough to read. Maybs a little substitution
will make things cleaner?

```
multiply 2_ 2_ =>
(\n m t. n (m t)) 2_ 2_ =>
\t. 2_ (2_ t) =>
\t. 2_ (\x. t (t x)) =>
\t. \z. (\x. t (t x)) ((\x. t (t x)) z) =>
\t. \z. (\x. t (t x)) (t (t z)) =>
\t. \z.t (t (t (t z))) =>
\t z. t (t (t (t z))) =>
4_
```

I don't think that helped much. There is, clearly, a reason why we do not write
programs directly in lambda calculus.

# 3 Conditionals

```
true = \x y.x
false = \x y.y
```

Why these expressions? Probably because it's convenient to have
`false` be the same expression as `0_`:

```
false => \x y. y => \s z. z => 0_
```

This matches the common convention found in imperative programming languages.
We could choose to make `true` equal zero instead, and then change all the
logic functions by negating their inputs, so `(and a b)` in the usual way
becomes 

```
(and (not a) (not b))
```

But I'm not sure if there's any tangible
benefit to doing this other than being contrarian.

## 3.1  Logical operations

```
and = \x y. x y (\x y. y) => \x y. x y false
```

The first parameter of `and` returns the second parameter, if it is `true`
and `false` if it is `false`. The only way `And` returns `true` is if both
parameters are `true`.

or = \x y. x (\x y. x) y = \x y. x true y ``

Same general idea as ``And``. The first parameter selects `true` if `true`
and `y` if `false`.

```
not = \x. x false true
```

Straightforward, it's just flipping the order of the parameter.

## 3.2 A conditional test

```
isZero = \x. x false not false
```

If x is `0_`:

```
isZero 0_ => (\x. x false not false) 0_ =>
0_ false not false => 
not false => 
true 
```

If x is `1_`:

```
isZero 1_ => (\x. x false not false) 1_ =>
1_ false not false => 
(\x y. y) not false => 
(\y. y) false => 
false 
```

If x is `2_`:

```
isZero 2_ => (\x. x false not false) 2_ =>
2_ false not false => 
(\x y. y) ((\x y. y) not) false => 
(\y. y) false => 
false 
```

It doesn't matter how many times we apply `false` to `not`
because `false` applied to any expression is always the Identity
function.

## 3.3 The predecessor function

The predecessor function `pred` is like the opposite of the successor
function `succ`. Instead of adding one to a number, it subtracts one from a
number (the words increment and decrement are sometimes used in other contexts
to describe adding or subtracting one, respectively).

Since numbers are functions that take other functions (higher-order functions),
and apply them a certain number of times, predecessor can be thought of as
an "apply one less time than this number" function.

Recall that `succ` is 

    succ = \n f x. f (n f x)

Naively, we might want something that looks like this

```
pred n = \n f x. (invert f) (n f x)
```

where `(invert f)` is the inverse function of `f`:

```
(invert f) (f x) = x
```
But we have a problem: Not every function is invertible.

Take `false` for example:

```
false x = (\x y. y) x = (\y. y) = id
```

Since `false` of any argument `x` is the `identity` function, and since
a function can only have one ouput for any given input, there's no
way for us to build an expression for `(invert false).` And that means
that we can build an `invert` function that is *total*, in that it is
defined over all possible inputs.

But it turns out it is possible to build a total `pred` function,
but we have to try another method. Instead of starting from `n` and working
backwards, we'll start from `0_` and build forwards. If we apply 
`succ` `n`-times to `0_`, we get `n`. So if we
apply `succ` only `(n-1)`-times to `0_`., /e'll get `n - 1` which is
`pred n.`

We'll start by building an expression that holds a pair of numbers, `a_`
and `b_`. Suppose we just put them next to each other:

```
a_ b_ 
```

This might look fine at first, but watch what happens if we give them concrete
values:

```
0_ 0_ => (\s z. z) (\s z. z) 
=> \z.z
```

The numbers evaluate against each other! Let's add an abstraction to stop the
application:

```
\x. a_ b_ 
```

Okay, that stops the application, but only temporarily. If we ever
apply this expression to anything, it'll just reduce back again and throw away
the values in the pair.

What we want is some way to access the two individual values in the pair.

```
\x. x a_ b_
```

We already have functions which will return only their first or second arguments:
`true` and `false`. We can use these to select which element
of the pair we want:

```
(\x. x a_ b_) true  = a_
(\x. x a_ b_) false = b_
```

Great, we've got a pair! Now we need a function which we'll call `phi` to turn
a pair of numbers `(a, b)` into `(a + 1, a)`

```
phi = \p z. z (succ (p true)) (p true)
```

For example,

```
(\p z. z (succ (p true)) (p true)) (\x. x 2_ 1_) =>
(\z. z (succ ((\x. x 2_ 1_) T)) ((\x. x 2_ 1_) T))  =>
(\z. z (succ ((\x. x 2_ 1_) T)) ((\x. x 2_ 1_) T))  =>

```

Now we just need to apply `phi` to `\x. x 0_ 0_`,
`n`-times, and the first element will be equal to `n` and the second will
be `n - 1`:

```
\n. n phi (\z. z 0_ 0_)
```

But since this function is supposed to be the predecessor, we really just want the
second element:

```
pred n = \n. n phi (\z. z 0_ 0_) F
```


## 3.4 Equality and inequalities

A number, `x` is greater than or equal to a number `y`  if applying predecessor
`x`-times to `y` is 0:

```
gte x y = \x y. isZero (x pred y)
````

The reason this function is "greater than or equal to" and not just "equals"
is that the predecessor of `0` is `0`.

But we can get an equals function by simply doing:

```
eq x y = \x y. and (gte x y) (gte y x)
```

Then, not equal is:

```
neq x y = \x y. not (eq x y)
```

Greater than:
```
gth x y = \x y. and (gte x y) (not x y) 
```

Less than or equal to:

```
lte x y = \x y. not (gth x y)
```

Less than:

```
lth x y = \x y. not (gte x y)
```

# 4 Recursion


**recursion**: A pattern where a function calls itself.

The basic idea behind recursion in lambda calculus is that we want to build an
expression that regenerates itself as we reduce it. What I mean by that is
if a function `F` is going to apply itself inside itself, it's reduction needs 
to somehow build a new copy of `F`. We're going to want to end up with some
function that transforms `F` into a sequence of repeated applications
of `F`:

```
F (F (F ....)))
```

Imagine we want to apply an expression `F` to itself once. If `F` is the 
identity function `id`:

```
id id => (\x.x) (\x.x) => \x.x 
```

Let's say we want a function that does this self-application, that we'll
call `M`:

```
M = \f. f f 
```

Now supppose we apply `M` to `M`:

```
M(M) = (\f. f f) (\f. f f) =>
(\f. f f) (\f. f f) => \dots
```

This is an infinite loop! `M(M)` regenerates itself perfectly, so that any
reduction just goes `M(M) => M(M) ...` . `M(M)` is in fact the
classic case of a non-terminating lambda expression, and is usually called
&Omega;).

Infinite loops are cool, but what we really want is to modify `M(M)` so that
we add an application of a function `R` at every loop:

```
M (\f. R (f f)) = (\f. f f) (\f. R (f f)) =>
(\f. R (f f)) (\f. R (f f)) =>
R ((\f. R (f f)) (\f. R (f f)) =>
R ( R ((\f. R (f f)) (\f. R (f f)))) =>
...
```

This is the famous `Y` combinator:

```
Y = (\f. f f) (\f. R (f f)) =>(\f. R (f f)) (\f. R (f f))
```

**combinator**: A lambda abstraction with no free variables.

---

Another way to think about the `Y` combinator is as a *fixed-point* combinator.

**fixed-point**. If `x = (f x)`, `x` is a *fixed-point* of the function `f`.

Suppose we have a function `fix` such that`(fix f)` that returns a fixed-point of
`f`. Then, by the definition of a fixed-point, 

```
(fix f) = f (fix f)
```

This can be expanded indefinitely as 

```
fix f => f (fix f) => f (f (fix f)) => ...
```

Which is precisely the same as the `Y` combinator:

```
Y f => f (Y f) = f (f (Y f))
```

so we can say that `Y` is the lambda expression that implements the function
`fix` for lambda functions.

---

We know know how to recurse a function `R` an infinite number of times:

```
Y R => R (Y R) => R (R (Y R)) => ...
```

But suppose we want to only recurse `R` a finite number of times:

```
Y R => R (Y R) => R (R (Y R)) => R ( R ( ... (R B)) ...)
```

We're going to have to bottom-out at some base-case `B`.

But how do we structure our function `R` so that it generates a base case, if
`YR => R(Y R)`? Won't that generate more copies of `R` no matter what we do?

Watch what happens if we apply `Y` to `0_`:

```
Y 0_ => Y (\s z. z) -> (\s z. z) Y (\s z. z) -> (\s z. z) -> 0_
```

`0_` throws away its first argument, and because it throws away the `Y`,
the recursion stops. So we if build an `R` that at some point throws
away the `Y` combinator, we'll lose our means of producing new copies of `R`.

Let's look at the example in the text, which is supposed to sum
all the integers between `n` and `0_`:

```
R = (\r n. isZero n 0_ (n succ (r (pred n))) )
sum n = Y R n 
```

Let's do some reductions on this, starting with `sum 0_`:

```
sum n = Y R 0_ =>
Y (\r n. isZero n 0_ (n succ (r (pred n)))) 0_ =>
(\rn.isZero n 0_ (n succ (r (pred n)))) (Y R) 0_ =>
(isZero 0_ 0_ (0_ succ ((Y R) (pred 0_)))) =>
true 0_ (0_ succ ((Y R) (pred 0_)))) =>
0_
```


Now `sum 1`:

```
Y R 1 =>
Y (\rn.isZero n 0_ (n succ (r (pred n)))) 1_ =>
(\rn.isZero n 0_ (n succ (r (pred n)))) (Y R) 1_ =>
(isZero 1_ 0_ (1_ succ ((Y R) (pred 1)))) =>
false 0_ (1_ succ ((Y R) (pred 1)))) =>
1_ succ ((Y R) (pred 1))) =>
1_ succ (Y R 0) =>
1_ succ 0 =>
1_
```

And `sum 2_` for good measure:

```
Y R 2_ =>
Y (\rn.isZero n 0_ (n succ (r (pred n)))) 2_ =>
(\rn.isZero n 0_ (n succ (r (pred n)))) (Y R) 2_ =>
(isZero 2_ 0_ (2_ succ ((Y R) (pred 2_)))) =>
false 0_ (2_ succ ((Y R) (pred 2_)))) => 
2_ succ ((Y R) (pred 2_))) =>
2_ succ (Y R 1_) =>
2_ succ (1_ succ 0_) =>
3_
```

Let's break this down into the general case:

```
loop = \ test f next start. Y (\r s. test s (f (r (next s)))) start
```

First we `test` our state `s` and return either `true` or `false`. In
the example in the text, `test` is `isZero` and `s` is a number `n`.

If our test returns `true` we terminate by returning our `base`, (`0_` in the
above example) otherwise we recurse
and return `f (r (next s))`. 
The function `f` is what we're actually interested in evaluating over our 
recursion. In the above the function `f` is `add n ` or `(n succ m)`.
The `r` is the stand-in for the rest of the recursion that will
be generated with a `Y R` application. And the `next` is `pred` in
the above example, because we want to count down from `n` to `0_` by
1s.

Supposing we want to loop a function `f` over
the numbers from `m_` to `0_` (technically the term is *fold* `f` over
the numbers `m_` to `0_`, but I don't want to get into folds just now).

All we have to do is fill apply to loop to the corresponding variables:

```
loop (\n. isZero n base) f pred m_ =>  
  Y (\r n. isZero n base 
          (f (r (pred n)))
    ) 
  m_
=> 
  (\r n. isZero n base (f (r (pred n)))) 
  ( Y (\r n. isZero base 
            (f (r (pred n)))
      )
  ) 
  m_
=>
(\r n. isZero base 
  ( f 
    ( (Y (\r n. isZero base (f (r (pred n)))))
      (pred m_))
  )
)
=>
...
```

In this way we can build a wide range of finite recursive structures.

# 5 Projects for the reader

[**N.B.**: I have not tested any of this code. I plan on writing a Lambda
Calculus interpreter at some point and when I do, I will test this code
and add a link back here.]

## 1 "less than" and "greater than"

See [section 3.4](#equality-and-inequalities)

## 2 Positive and Negative Integers

Let `(\x. x np nn)` be the pair of natural numbers `np`, and `nn`, the integer
`n` will then be the difference `np - nn`. In other words, `np` is the
positive component of `n` and `nn` is the negative component.

However, in this representation there will be many possible expressions
that signify the same integer. Let us then define the case where either
`np` or `nn` equals `0` as the canonical or simplified representation.

To make things easier let's define some aliases for handling pairs:

```
pair = \a b. (\x . x a b)
fst = \p. p true
snd = \p. p false
```

`pair` makes a pair out of two elements.
`fst` returns the first element of a pair.
`snd` returns the second element of a pair.

We can then define a function `simplifyInt` as:

```
simplifyInt = (\x. ( \ p n. (gte p n) 
                            (pair (n pred p) 0)
                            (pair 0 (p pred n))
                   ) 
                   (fst x)
                   (snd x)
              )

```

If `p` is greater than or equal to `n`, the number is positive, so we apply
`pred` `n` times to `p`, yielding an integer `(p - n, 0)`. Otherwise, 
we apply `pred` `n` times to `p`, yielding an integer `(0, n - p)`.

In either case, the integer is now in "lowest terms", so to speak.

## 3 Addition and Subtraction of Integers

Adding two integers `(p, n)` and `(q, m)` is the same as adding their 
components and simplifying:

```
addInt = \ x y. simplifyInt 
                (pair (add (fst x) (fst y)) 
                      (add (snd x) (snd y))
                )
```

Subtracting is the same as adding with sign-flip function, called `negate`:

```
negateInt  = \ x . pair (snd x) (fst x)
subtractInt = \ x y. addInt x (negateInt y)
```

## 4 Division of positive integers recursively

The positive integers are the natural numbers, so we'll have our
`div` function return a natural number.

If in `div x d` either `x` or `d` are negative, we'll return 0 to signify 
an error.

```
loop = \ test f next start. Y (\r s. test s ((f s) (r (next s)))) start

divUnsafe = \ x d. loop (\s . (lth s d)) 0) (\s. succ) (\s . d pred s) x

div = \x d. (\x d . (and (gte x 0) (gte d 0) (divUnsafe x d) 0))
            (fst (simplify x))
            (fst (simplify d))
```

## 5 Factorial

```
factorial = \n . loop (\n. isZero n 1) (\n. multiply n) pred n
```

## 6 Rational Numbers

Our rational number representation will be a pair of integers: a numerator
`x` and a divisor `y`:

```
pair x y
```

## 7 Addition, Subtraction, Multiplication, and Division of Rationals

First we're going to need a way to multiply integers,
if we have two integers `x = (p - n)`, and `y = (q - m)`, then `x`
multiplied by `y` is

```
(p - n) (q - m) = (pq + nm) - (nq + pm)
``` 

Since according to our integer representation, `p`, `n`, `q`, and `m` are
all natural numbers, we can do this:

```
multiplyInt = \x y. pair (add (multiply (fst x) (fst y)) 
                              (multiply (snd x) (snd y))
                         )
                         (add (multiply (snd x) (fst y)) 
                              (multiply (fst x) (snd y))
                         )
```

For adding rationals, since `a/b + c/d = (ad + cb)/bd`, and `a,b,c,d` are
all integers:

```
addR = \x y. pair (addInt (multiplyInt (fst x) (snd y)) 
                          (multiplyInt (fst y) (snd x))
                  ) 
                  (multiplyInt (snd x) (snd y))
```

For subtraction,  `a/b - c/d = (ad - cb)/bd`:

```
subtractR = \x y. pair (subtractInt (multiplyInt (fst x) (snd y)) 
                                    (multiplyInt (fst y) (snd x))
                  ) 
                  (multiplyInt (snd x) (snd y))
```

Multiplication, `(a/b) * (c/d) = (ac)/(bd)`:

```
multiplyR = \x y. pair (multiplyInt (fst x) (fst y)) 
                       (multiplyInt (snd x) (snd y))
```

Division, `(a/b) / (c/d) = (ad)/(cb)`:

```
divideR = \x y. pair (multiplyInt (fst x) (snd y)) 
                     (multiplyInt (snd x) (fst y))
```

## 8 Lists of Numbers

A list can be thought of as either a `nil` element or a `cons` of head and
a tail, where the head is an expression and the tail is a list.

If `x,y,z` are list elments then lists of lengths 0 to 3 are, respectively:

```
0-list = nil
1-list = cons x nil
2-list = cons x (cons y nil))
3-list = cons x (cons y (cons z nil))
```

Let's turn the above into abstractions on the variables `x,y,z,c,n` where
`c` stands for `cons` and `n` stands for `nil`:

```
0-list = \ c n. n
1-list = \ x c n. c x n
2-list = \ x y c n. c x (c y n)
3 list = \ x y z c n. c x (c y (c z n))
```

If we pass in elements to the above list constructors (so that `x_, y_, z_` are
now representing expressions rather than variables):

```
0-list = \ c n. n
1-list = \ c n. c x_ n
2-list = \ c n. c x_ (c y_ n)
3 list = \ c n. c x_ (c y_ (c z_ n))
```


This suggests a nice list encoding as the right-fold of some function `c`
over whatever we want our list elements to be, (with `n` as the base argument).

We already have our `nil` from the above as `\ c n . n`, now we need our
`cons` function.


At first glance the function 2-list looks like a decent definition for `cons`,
since it combines two elements into a list. 

```
2-list = \ x y c n. c x (c y n)
```

But our definition of `cons` is that it combines an element (the head) and a list 
(the tail) into a list, not two elements. 

Watch what happens if we pass an element `x_` and a list into `2-list`

```
\ c n . c x_ (c (\ c n. c a_ n) n)
```

In Haskell list notation, the above is `[x, [a]]`, not `[x, a]`, which
is what we want.

But since a list is a function of `c` and `n`, we can modify 2-list
slightly like so:

```
cons = \ x y c n. c x (y c n)
```

Now if we call `cons` with `x_` and `\ c n. c a_ n` we get

```
cons x_ (\ c n. c a_ n) =>
\ c n. c x_ ((\c n. c a_ n) c n) 
\ c n. c x_ (c a_ n) 
```

Which does what we want. I like to think of cons as folding some 
function `c` over the tail with `n` and then adding one more fold layer
of `c` with the head.

## 9 List Head 

Since our list is a fold of a function `c` over the elements
of a list, we call our list with `true`, or `\ x y. x` to throw away the tail.
As an example:


```
(\ c n. c x_ (c y_ n)) true =>
true x_ (c y_ n) =>
x_
```

But if the list is nil `\ c n. n` we want to return `nil`, so our `head`
function is actually: 

```
head = \ l. l true nil
```

## 10 List Length

We fold `(\ x. succ)` over the list with nil as `0_`:

```
length = \ l. l (\ x. succ) 0_
```

As an example,

```
length (\ c n. c x_ (c y_ n)) =>
(\ c n. c x_ (c y_ n)) succ 0_ =>
(\ x. succ) x_ ((\ x. succ) y_ 0_)) =>
(succ (succ 0_)) =>
2_
```
We add the extra abstraction over `succ` to throw away the list elements.

## 11 Turing Machine

So the rest of this document is fairly self-contained, but this question is
introducting a pretty big conceptual dependency. Namely, what precisely is
a Turing Machine?

I'll cover this in a future post and link back here.

Also, if I'm going to write a Turing Machine in Lambda Calculus, I absolutely
want to write proper executable code. Writing massive walls of pseudocode that
don't do anything is no fun. Code is meant to run! 

So I'm going to go write a Lambda Calculus interpreter, vivify all the dead 
notation in this document, and then come back to this question.
















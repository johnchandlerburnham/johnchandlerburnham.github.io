---
title: "Workthrough: Haskell Programming (Allen & Moronuki)"
author: jcb
date: 2017-11-01
tags: workthrough, haskell
---

**Work in progress**

# Preliminaries

This page contains my notes and exercise solutions for the text
"Haskell Programming From First Principles" by Chris Allen and Julie Moronuki.

Brief review: I love this book. I love Haskell. I worry this book has been so
good at teaching me Haskell that I love other languages less by comparison.
The book's philosophy of "Let's break complicated topics down into simple
pieces, and then play with the pieces until they become obvious." is so
effective, that I'm going to just reflexively hold every other CS book to the
same standard from now on. This is going to leave me very disappointed,
considering that most other programming books don't come anywhere near this
fun.

Okay, maybe that's a little hyperbolic. I don't want to give the impression
that HPFP is a text without flaws. In my notes on the rest of this page, I
imagine I'll be going into those flaws in some depth. But before I do I want to
make it perfectly clear that this book is spectacular and any criticism of mine
is made with the greatest possible love and affection. 

I deeply admire what Julie Moronuki and Chris Allen have accomplished here, and
I encourage anyone interested in programming to buy a copy at
[www.haskellbook.com](www.haskellbook.com). I am also eagerly awaiting
Julie's upcoming book [The Joy of Haskell](https://joyofhaskell.com/) and
Chris' [Haskell Almanac](https://lorepub.com/product/cookbook). 

Before we get started, a little housekeeping: This page contains notes and
solutions, but it is not a Haskell tutorial in its own right. My intended reader
is someone who has already bought HPFP and maybe wants to check their own
work against someone else's. 

Also, each chapter of HPFP has a list follow-up resources at the end. In my
chapter notes, I'll link to separate posts containing my notes on each of these
resources.

Lastly, my GitHub repository containing my solutions for HPFP is
[here](https://github.com/johnchandlerburnham/haskellbook). While this page is
marked **Work In Progress**, I make no guarantees as to whether the code there
matches the code here. But I do plan on bringing them into alignment ultimately.

Awesome, let's get started.

---

# 1 All You Need is Lambda

## 1.3 What is a Function?
**Function**: A relation between an input set and output set such that each
input has only one ouput. Personally, I think its more intuitive to imagine a
function as a transformation that changes one type of thing (the input set)
into another type of thing (the output set). I like to imagine a vegetable
juicer: Put carrots in, get carrot juice out. Put spinach in, get spinach juice
out. What is the *function* of a vegetable juicer? It transforms vegetables
into vegetable juice. The set of things that can go into a vegetable juicer are
its input set (or *domain*) and the set of things that can come out are its
output set (or *codomain*). 

**Computable functions**: If a function is a transformation between two sets of
things, and we can build machines which do transformations, then any function
for which we can build a machine is called a **computable** function. Not all
functions are computable.

**Turing Machines**: A simple model of a computer based on manipulating symbols
on a tape according to some rules and an internal state. Despite its
simplicity, a Turing Machine can be built that executes any computable
function.

**Lambda Calculus**: A simple model of computation based on building, 
applying, and evaluating functions. A function built using the Lambda 
Calculus is called a lambda expression, and for any computable function, 
a lambda calculus can be constructed which evaluates that function.

**parameter**: An input to a function.

**"functions are first-class"**: Functions can be parameters.

**referential transparency**: The property that the same function with
the same parameters returns the same output. All functions are referentially
transparent over all their parameters, but in some situations it can 
be difficult to tell what all a functions' parameters are. Suppose you turn
a dozen carrots into carrot juice with a vegetable juicer, don't clean the
juicer afterwards. You'll drink your carrot juice, but the next person to use
the juicer will have carrot flavored juice, even if they wanted celery and
ginger. The juicer function has hidden paramters, i.e.  the residue of previous
inputs. Functions like this can be described as *stateful*, because they have
some internal or hidden parameters whose state can affect the output of the
whole function.

**purity**: A synonym for referential transparency.

**Functional programming**: Building machines (programs) that evaluate
computable functions using the lambda calculus.

## 1.4 The Structure of lambda terms

**abstraction**: A lamda expression that represents a function. It can be
written down with the folowing notation: $\lambda x.x$. Everything between the
$\lambda$ and the $.$ is called the **head**, and the symbol in the head names
the parameter of the function. After the $.$ is the **body**, and describes
what to do with the parameter, when the abstraction is applied. Terms that
occur in both the **head** and the **body** are called *bound variables*, and
symbols that only appear in the body are called *unbound*, or *free variables*.

**currying**: Properly speaking, all abstractions have only single parameters.
Functions with multiple paramters are expressed as a nested strucure of single-
parameter functions. For example $\lambda xy.xy$ is more properly written as
$\lambda x.(\lambda y.xy)$.

**application**: A lambda expression can be applied to some input like so:
$((\lambda x.x) N)$. Following the reductions steps will evaluate the function
described by $\lambda x.x$ with input parameter N.


## 1.5 Beta reduction

**alpha equivalence**: Within an abstraction, the specific symbols in the head
may be replaced by other symbols as long as the replacement is consistent and
total. For example, in the abstraction $\lambda x.x$ the term $x$ in the head
may be replaced with $y$, so long as all instance of $x$ in the body are also
replaced with $y$. Thus, $\lambda x.x$, $\lambda y.y$, and any other
expression of the form $\lambda n.n$ (for some $n$) are alpha equivalent.

**beta reduction**: An abstraction is evaluated by replacing all its bound
variables with the expression the abstraction is evaluated against (its input),
and then removing the head of the abstraction. For example, $((\lambda x.x) N)$
would be evaluated by replacing all $x$'s in the body with $N$ (yielding
$\lambda x.N$) and then removing the head for the final output of $N$.

### Intermission: Equivalence Exercises (p.13)

1. `\xy.xz` is equivalent to `\mn.mz`, by alpha equivalence of `x` with `m`
and `y` with `n`.
2. `\xy.xxy` is equivalent to `\a.(\b.aab)`, by currying and alpha equivalence.
3. `\xyz.zx` is equivalent to `\tos.st`.

## 1.7 Evaluation is simplification

**beta normal form**: When an expression cannot be further reduced through
*beta reduction* (i.e. application of abstractions). This signals the end
of the evaluation.

**combinator**: A lambda term with no free variables. $\lambda x.x$ is a combinator,
$\lambda x.xy$ is not.

**divergence**: If an expression can never reach *beta normal form*, it 
is said to diverge. For example, $(\lambda x.xx)(\lambda x.xx)$ diverges.
This corresponds to non-terminating function (an infinite loop).

## 1.11 Chapter Exercises (p.17)

### Combinators
1. `\x.xxx` is a combinator.
2. `\xy.zx` is not a combinator, `z` is free.
3. `\xyz.xy(zx)` is a combinator.
4. `\xyz.xy(zxy)` is a combinator
5. `\xy.xy(zxy)` is not a combinator, `z` is free

### Normal form or diverge?
1. `\x.xxx` is Normal
2. `(\z.zz)(\y.yy)` diverges
3. `(\x.xxx)z` is Normal

### Beta Reduce

1. `(\abc.cba)zz(\wv.w)` reduction:
    ``` 
    (\abc.cba)zz(\wv.w) ->
    (\bc.cbz)z(\wv.w) ->
    (\c.czz)(\wv.w) ->
    (\wv.w)zz ->
    (\v.z)z ->
    z
    ```
  
2. `(\x.\y.xyy)(\a.a)b` reduction:
    ```
    (\x.\y.xyy)(\a.a)b ->
    (\y.(\a.a)yy)b ->
    (\a.a)bb ->
    bb
    ```


3. `(\y.y)(\x.xx)(\z.zq)` reduction:
    ```
    (\y.y)(\x.xx)(\z.zq) ->
    (\x.xx)(\z.zq) ->
    (\z.zq)(\z.zq) ->
    (\z.zq)q ->
    (\z.zq)q ->
    qq
    ```

4. `(\z.z)(\z.zz)(\z.zy)` reduction:
    ```
    (\z.z)(\z.zz)(\z.zy) ->
    (\z.zz)(\z.zy) ->
    (\z.zy)(\z.zy) ->
    (\z.zy)y ->
    yy
    ```

5. `(\x.\y.xyy)(\y.y)y` reduction:
    ```
    (\x.\y.xyy)(\y.y)y ->
    (\y.(\y.y)yy)y
    (\y.y)yy
    yy
    ```

6. `(\a.aa)(\b.ba)c` reduction:
    ```
    (\a.aa)(\b.ba)c ->
    (\b.ba)(\b.ba)c ->
    (\b.ba)ac ->
    aac
    ```

7. `(\xyz.xz(yz))(\x.z)(\x.a)` reduction:
    ```
    (\xyz.xz(yz))(\x.z)(\x.a) ->
    (\z.(\x.z1)z((\x.a)z))
    (\z.z1a)
    ```

## 1.14 Follow-up Resources

1. [Raul Rojas. A Tutorial Introduction to the Lambda 
    Calculus](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)

    My notes: [Workthrough: A Tutorial Introduction to the Lambda Calculus
    (Rojas)](posts/workthrough-lambda-calculus-rojas.html) 

2. [Henk Barendregt; Erik Barendsen. Introduction to Lambda
   Calculus](http://www.cse.chalmers.se/research/group/logic/TypesSS05/
   Extra/geuvers.pdf)

    [TODO: Notes on this Resource]

3. [Jean-Yves Girard; P. Taylor; Yves Lafon. 
   Proofs and Types](http://www.paultaylor.eu/stable/prot.pdf)

    [TODO: Notes on this Resource]

---

# 2 Hello Haskell!

## 2.1 Hello, Haskell

**GHC**: The Glagow Haskell Compiler is a program (written in 
Haskell and C) turns Haskell code into x86 or ARM executables. There
are [many other Haskell compilers](https://wiki.haskell.org/Implementations),
but GHC is the de facto standard. Some Haskell compilers, such as Hugs, UHC
and Yhc are no longer actively developed, but are notable for historic reasons,
others, such as ghcjs and Frege (technically a separate dialect) are also
important, since they target different platforms than GHC (Javascript and the
JVM, respectively).  

**GHCi**: GHC's interactive mode, or [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop). A REPL, or read-eval-print-loop, reads code
that you type into a command line shell, evaluates it, prints the results,
and then loops so you can type in more code.

**Cabal**: Haskell's Common Architecture for Building Applications and
Libraries. When we write software, we often want to include external
libraries, Cabal is a tool that enables us to easily include those libraries
in our own software, as well as to publish libraries that can be used by others.

**Hackage**: A central package archive which contains most of the Haskell
libraries you're ever going to want to use. Cabal installs packages from
Hackage by default.

**Cabal hell**: When we install external libraries using cabal, those
libraries are installed globally on our machine by default. This means that
if we want to build two different projects that depend upon the same external
library, the naive way to do so is to install that library on our machine
with cabal and then include it in our projects. This seems innocuous, but
is actually very bad, because it creates a hidden interdependence between
our two projects. 

  Suppose the library author added some new features in the library that we
want to use in one of our projects. It seems obvious that we could just
update the library and modify our project to use the new features, right?
Except if we do that, we might break every other project on our machine that
depends on that library, if the updated version wasn't backwards compatible.
And if the project that we're currently working on itself depends on one of
the other now-broken projects, we have to dive into a tangled web of hidden
interdependencies to get anything working. This pattern, is called
**dependency hell**, in general and is certainly not unique to cabal.  There
are a number of different ways to manage this problem, but the general
approach is to use some other tool that allows you to install multiple copies
of the same library on a per project basis so that changes in one project
don't propagate to other projects. Cabal itself provides a mechanism for
doing this which allows you to install packages into self-contained
"sandboxes," but there are other tools, such as Stack (see below), which is
what HPFP uses. 

One extremely interesting way to solve the problem of dependency management 
that I should note is to use a system package manager like Nix or Guix that
supports this type of package sandboxing and referentially transparent builds
for anything you install on your machine, not just Haskell packages (which is
all Cabal or Stack deals with). And you can even extend this to running an
entire OS, like NixOs or GuixSD that manages the whole OS this way. That is,
you can install the Nix package manager on e.g. macOS, but macOS packages or
applications won't be self-contained. In NixOs however, everything, including
OS libraries have isolated dependencies, which makes it radically more
difficult to break things when you, for example, update your operating system.

**Stack**: A tool for building Haskell projects and manage dependencies. I like
to think of Stack as a really nice user interface over a lot of common  Haskell
development functionality like installing packages with cabal, or managing
different versions of GHC. Stack also installs packages from Stackage which is
a mirror of Hackage that makes some guarantees about packages being compatible.
Libraries on Hackage are more like nightly or unstable builds, up to date, but
possibly brittle.  Libraries on Stackage are farther behind, but stable.

**Installating Stack**:

I started the book with [Arch Linux](archlinux.org) as my operating system,
but I switched to [NixOS](nixos.org) part of the way through. Setting up
Stack on Arch was really easy, but maintaining it proved fairly nontrivial. 
Apparently, just naively updating GHC and Stack with pacman (Arch's package
manager) can result in some epic dependency hell.

When I investigated, I found a post somewhere (which I can't seem to find now)
that proposed the following:

1. Install stack with pacman
2. Install stack again with stack. 
3. Remove the system package of stack with pacman.
4. Use the stack that stack installed

This was too silly for me to even try, but the fact that it seemed almost 
plausible told me that I should probably do my Haskell work on a different 
OS. So I added a NixOS partition on my machine on the theory that it's
better to have a system that's difficult to learn and easy to debug
than the other way round.

Accordingly, installing Stack on NixOs in a way that things seem to mostly
behave was non-trivial. But it's been pretty smooth sailing ever since (knock
on wood). Here's a rough outline of what I did:

\[N.B. As I learn NixOS and Haskell better, I'll edit this and add better
instructions\]

1. Installed Stack by adding stack to my system packages in my configuration.nix 
2. Enabled Stack's Nix integration by adding 
    ```
    nix: 
      enable: true
      shell-file: shell.nix
    ```
  to the stack.yaml of any project I'm using stack with.
3. Add the following shell.nix file to my project's root directory
    ```
    # shell.nix 

    {ghc}:
    with (import <nixpkgs> {}); 

    haskell.lib.buildStackProject {
      inherit ghc;
      name = "myEnv";
      buildInputs = [ zlib ];
      buildPhase = ''
        export LANG=en_US.UTF-8
      '';
    }
    ```

There may be some other minor steps that I've missed, but these are the main
ones I remember.  This is a pretty boilerplatey solution, but considering this
book really depends on Stack I thought it better to stick to the text rather
going the [cabal2nix](https://github.com/NixOS/cabal2nix) route and having a
more idiosyncratic build process.

## 2.5 Understanding expressions

There's a lot of inferential distance between the previous chapter and
this one. I think it's important to point out that even though Haskell is
based on the lambda calculus, they are by no means the same 
thing. Lambda Calculus is the theoretical foundation of a lot of languages,
Haskell being only one of them. But even if the foundations are the same,
the structure of the languages might be very different, based on the decisions
of its designers. Start with Lambda Calculus, build one kind of structure,
and you get Haskell, but start over and build a different kind of structure
and you get Lisp.

The book skips over a lot of those design decisions and rightly so. Better
to get started playing with the language as soon as possible. But you should at
least be aware that there is some hidden complexity here. And
if you find yourself stuck on some concept, it's probably because 
some implicit detail, which the author knows but you don't, is blocking you. 

This happens to everyone. Just remember that every big complicated concept in
computer science is made up of little obvious steps. Computers can only do
little obvious steps, but they do very many of them very very fast. Whenever
you're stuck, go back to the last step that was obvious to you, and try
to figure out what the next obvious step is.

In this case, I highly recommend the follow-up resources in the previous
chapter, which are a great place to start at trying to close the complexity gap
between Haskell and the lambda calculus.

### Exercises: Comprehension Check

1. `let half x = x /2`
   `let square x = x * x`

2. `let area x = 3.14 * (square x)`
3. `let area x = pi * (square x)`


## 2.6 Infix Operators

It may be helpful to point out that all infix operators are just syntacic 
sugar over functions.

**syntacitc sugar**: Syntax within a programming language that is designed to
make things easier to read or to express. It makes the language "sweeter" for
human use: things can be expressed more clearly, more concisely, or in an
alternative style that some may prefer. (from [Wikipedia](https://en.wikipedia.org/wiki/Syntactic_sugar))

```haskell
Prelude> add = (+)
Prelude> add 2 2 
4
Prelude> 
```
### Exercises: Parentheses and Association
**Precedence**: Where the implicit parentheses are. Precedence of operators is
only relevant if you leave out parentheses. If you can explicitly mark
what operations you want evaluated in what order, precedence doesn't matter.
Or, in other words, parentheses have the highest precedence, just like
in grade school (the P in PEMDAS stands for parentheses).


1.  a. `8 + 7 * 9`
    b. `(8 + 7) * 9`
  
    a and b are different, `(*)` has a higher precedence than `(+)`

2.  a. `perimeter x y = (x * 2) + (y * 2)`
    b. `perimeter x y = x * 2 + y * 2`

    a and b are the same, `(*)` has a higher precedence than `(+)`

3.  a. `f x = x / 2 + 9`
    b.  `f x = x / (2 + 9)`

    a and b are different  `(/)` has a higher precedence than `(+)`

## 2.7 Declaring values

Look at the following sequence of expressions in GHCi:

```haskell
Prelude> let x = 3
Prelude> let y = x + 1
Prelude> y
4
Prelude> let x = 7
Prelude> x
7
Prelude> y
4
```

You may have been expecting that last `y` to be `8` instead of `4`, which
is how it would work in an imperative language like C or Python.

What's curious about Haskell though is why the above sequence works
at all. Look what happens if we try to replicate
similar looking expressions in a source file:

```haskell
--- SevenIsNotThree.hs

module SevenIsNotThree where
                                                                                
x = 3                                                                           
y = x + 1                                                                       
x = 7    
```

If you try loading this into GHCi:

```haskell
Prelude> :l SevenIsNotThree.hs 
[1 of 1] Compiling SevenIsNotThree  ( SevenIsNotThree.hs, interpreted )

SevenIsNotThree.hs:7:1: error:
    Multiple declarations of ‘x’
    Declared at: SevenIsNotThree.hs:5:1
                 SevenIsNotThree.hs:7:1
Failed, modules loaded: none.
```

Haskell's error messages take a little getting used to, so I'll translate:

```haskell
Dear Sir or Madam,

While the Prelude module was loaded, you, the Programmer, instructed
us to load the module found in the file SevenIsNotThree.hs.

We located the aforementioned file, SevenIsNotThree.hs and attempted to load
the module SevenIsNotThree we found therein.

At line 7, column 1, in file SevenIsNotThree.hs, we encountered an error:
  You tried to declare the expression 'x' mulitple times.
  You declared 'x' at  line 5, column 1 of file SevenIsNotThree.hs
  You declared 'x' at  line 7, column 1 of file SevenIsNotThree.hs

Declaring an expression multiple times is forbidden. 
  Either the declarations are the same
    and thus redundant,
  Or the declarations are different
    and thus contradictory.

We have no desire to load redundant and contradictory code. Therefore, your
request is denied and no modules were loaded.

Sincerely,
The Glorious Glasgow Haskell Compiler (interactive mode).
```

Don't worry, GHC isn't scolding you (much). You shouldn't want to 
run redundant or contradictory code either. Much better to find out that your
code is broken in a message from the compiler than, for example, when your Mars
Lander crashes into the surface because your code had a type error and mixed up
feet and meters (this actually
[happened](https://en.wikipedia.org/wiki/Mars_Climate_Orbiter#Cause_of_failure)).

As for why GHC is perfectly happy to accept contradictory declarations
in GHCi let expressions but not in a source file, this is because everything
in GHCi happens inside the `IO ()` type (IO meaning input/output). `IO` let
expressions have different scope than declarations in a source file. 

This seems mysterious, but will make sense in later chapters.

### Exercises: Heal the Sick

1. `let area x = 3.14 * (x * x)`
2. `let double x = x * 2`

3.  ```haskell
    -- Levels.hs
    module Levels where

    x = 7
    y = 10
    f = x + y
    ```

## 2.8 Arithmetic functions in Haskell

Oh, gosh. Modular arithmetic. 

My recommendation is to read the chapter and read this Wikipedia page on
the [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation).
You'll see there that pretty much every programming language has its
own idiosyncratic way of doing the modulo operation, and there isn't a lot of
consistency between them.

By the way, `divMod` and `quotRem` are two useful functions which return
pairs of `div` and `mod`, and `quot` and `rem`, respectively, applied to
the same arguments:

```haskell
divMod x y = (div x y, mod x y)
quotRem x y = (quot x y, rem x y)
```

In my opinion I wouldn't stress too much about all the detail here.
In practice, `div` and `mod` are almost always what you need, and that the
distinction between `divMod` and `quotRem` only appears when you're dealing
with negative integers. Really the difference is just what "round down" means.

Let's look at a few examples of how `divMod` and `quotRem` differ:

```haskell
Prelude> divMod 13 4
(3,1)
Prelude> quotRem 13 4
(3,1)
```

Both arguments are positive, so there is no difference. `13` divided by `4` the
ordinary way is three and a fourth, `3.25`. But since this is integer
division we round down to `3`. Since `3 * 4` is `12` the remainder is one (`13 -
12 = 1`).

But what if we do `(-13)` divided by `4`. If we were doing ordinary division
we would get negative `(-3.25)`. 

Now this is the question: What does it mean to "round down" `(-3.25)`?

The two possible options are `(-3)` and `(-4)`. 

If we say that `(-3.25)` rounded down is `(-3)`, then we run into the 
difficulty that `(-3)` is actually greater than `(-3.25)`:

```haskell
Prelude> (-3) > (-3.25)
True
```

On the other hand, if we say that `(-3.25)` rounded down is `(-4)` then
it's the absolute value which is greater:

```haskell
Prelude> abs (-4) > abs (-3.25)
True
```

So we have a choice to make. We want integer division to "round down", but
when one of the arguments is negative, "down" can mean two different things.
We have to decide if we want "down" to be toward `0`, in which case we'll
choose `(-3)` in the above example, or towards $-\infty$, negative infinity,
in which case we choose `(-4)`.

```haskell
Prelude> divMod (-13) 4
(-4,3)
Prelude> quotRem (-13) 4
(-3,-1)
```

As we can see, `divMod` sets down as $-\infty$ and `quotRem` sets down
as `0`.

The values for `mod` and `rem`, are just consequences of that choice,
since:

```haskell
mod (-13) 4 = (-13) - 4 * (div 13 4) = (-13) - 4 * (-4) =
-13 + 16 = 3

rem (-13) 4 = (-13) - 4 * (quot 13 4) = (-13) - 4 * (-3) =
-13 + 12 = -1
```

Everything is just a consequence of what we want "down" to mean.

If we flip the signs of the arguments:

```haskell
Prelude> divMod 13 (-4)
(-4,-3)
Prelude> quotRem 13 (-4)
(-3,1)
```

`div` and `quot` are the same, because `13` divided by `(-4)` is still `(-3.25)`
and the decision about "down" is the same.

`mod` and `rem` are different though, because:

```haskell
mod 13 (-4) = 13 - (-4) * (div 13 4) = 13 + 4 * (-4) =
13 - 16 = -3

rem 13 (-4) = 13 - (-4) * (quot 13 4) = 13 + 4 * (-3) =
13 - 12 = 1
```

Lastly, if we set the signs of both arguments negative:

```haskell
`(-13)` / `(-4)` = 13 / 4 = 3.25
```

and we're back to "down" being unambiguous, so `divMod` and `quotRem`
are the same again.

```haskell
Prelude> divMod (-13) (-4)
(3,-1)
Prelude> quotRem (-13) (-4)
(3,-1)
```

But really. Just use `divMod`. You almost always want "down" to be towards
negative infinity. 

I would almost rather manually recreate `quot` out of `div` wherever I 
needed it: 

```haskell
quot x y = (sign x) * (sign y) * (div (abs x) (abs y)) where
  sign x = div (abs x) x
```

Just so that it's perfectly clear that I'm really interested in rounding 
absolute values. 


## 2.9 Parenthesization

`$`, or "apply", is a great help in making Haskell code legible. 

Look at the difference between

```haskell
fun x = (foo (bar (baz x)))

fun' x = foo $ bar $ baz x
```

I think the latter is a lot nicer. But the difference gets even starker
when you have a more complicated syntax structure:

```haskell
lessFun x = (qux (baz (bar x)) (foo (bar x)) (baz (quux (foo (bar x)) (foo x))))
```

My eyes glaze over after the first bar.

```haskell
moreFun x = qux (baz $ bar x) (foo $ bar x) (baz $ quux (foo $ bar x) (foo x))
```

Now it's a lot easier to tell that qux takes three arguments. 

We could also do:

```haskell
moreFun x = qux (baz $ bar x) (foo $ bar x) $ baz $ quux (foo $ bar x) $ foo x
```

But I think this is less clear. In general I like to use parentheses and `$` 
to better illuminate the structure of whatever the expression is, which
depending, on the specific expression that might require slightly different
styles. `let` and `where` expressions can also be a great help. 

```haskell
moreFun' x = qux (baz $ bar x) fbx (baz $ quux fbx $ foo x) where
  fbx = foo $ bar x
```


### Exercises: A Head Code 

1. `let x = 5 in x` 

    returns 5

2. `let x = 5 in x * x` 
  
    returns 25

3. `let x = 5; y = 6 in x * y` 
    
    returns 30

4. `let x = 3; y = 1000 in x + 3` 

    returns 6

**Rewrite with where clauses**:

1. `x * 3 + y where x = 3; y = 1000`
2. `x * 5 where y = 10; x = 10 * 5 + y`
3. `z / x + y where x = 7; y = negate x; z = y * 10`

## 2.11 Chapter Exercises

### Parenthesization

1. `2 + (2 * 3) - 1`
2. `(^) 10 $ (1 + 1)`
3. `(2^2) * (4^5) + 1`

### Equivalent expressions

1. `1 + 1` returns the same as `2`

2. `10^2` returns the same as `10+9*10`

3. `400 - 37` is not the same as `(-) 37 400`, different argument order.

4. ``100 `div` 3`` is not the same as `100 / 3`, former is integer division vs
fractional division for the latter.

5. `2 * 5 + 18` is not the same as `2 * (5 + 18)`, operator precedence

### More fun with functions

1.  `10 + waxOn` will return 1135

    `(+10) waxOn` will return 1135

    `(-) 15 waxOn` will return -1110

    `(-) waxOn 15` will return 1110

2. Nothing to do for this exercise

3. 3375

4.  see morefun.hs

5.  see morefun.hs

6.  see morefun.hs
    ```haskell
    -- morefun.hs

    waxOn = x * 5 where x = y ^2; y = z + 8; z = 7
    triple x = x * 3
    waxOff x = triple x
    ```

7.  `waxOff 10` returns `30`

    `waxOff (-50)` returns `(-150)`

## 2.13 Follow-up resources

1. [Haskell wiki article on Let vs Where](https://wiki.haskell.org/Let_vs._Where)
  
    [TODO: Notes on this resource]

2. [How to desugar Haskell code; Gabriel Gonzalez](https://github.com/johnchandlerburnham/hpffp-resources/blob/master/Chapter%202/How%20to%20desugar%20Haskell%20code.pdf)

    [TODO: Notes on this resource]

--- 

# 3 Strings

**string**: a sequence of characters, usually representing text. The words
you are reading now are strings.

**Haskell's `String` type**: A particular way of representing strings as 
lists of `Char` types. It is very important to notice that even though
the name of this type is `String`, it is not the only, or even the best
way to represent sequences of characters and text. (see [Data.Text](https://hackage.haskell.org/package/text-1.2.2.2/docs/Data-Text.html) and [Data.ByteString](https://hackage.haskell.org/package/bytestring-0.10.8.2/docs/Data-ByteString.html)


The main advantage of `String` is that it is conceptually very simple: a `String`
is a `List` of `Char`. 

### Lists

A list (with a lowercase l) is some ordered collection of information. The
order may not be important, but if there is no order, it's not a list, it's
a set ("unordered list" is a bit of a misnomer).

Suppose you buy groceries for your family every week. You want to know what everyone
else wants from the store without having to talk to them each individually, so
you put a piece of paper on the fridge and tell everyone to write down what 
they want you to get. This is an everyday example of a list: A grocery list.

```
Grocery List
------------
- Milk
- Eggs
- Flour
- Chicken Noodle Soup 
- Mushrooms
- Beef tenderloin
- Puff pastry
```

A grocery list is an everyday example of a list. The order of your grocery list
probably isn't important but there definitely is an order: The groceries
aren't written randomly all over the page, but in parallel lines starting
from the top of the page downward.

The order of the list could indicate the chronological
order in which people added their requests. That's probably not 
important information most of the time, but occasionally it might be.

In the above example, notice that the first item on the list is `Milk`. If
the list is chronological, it means that `Milk` was the first thing added
since you went to the store last week. If you know you bought a half-gallon of
`Milk` last week, that probably means your family drank all the `Milk` right
after you bought it. And that might make you decide to buy a whole gallon
this time.

Another interesting thing you can see in the ordering of a grocery list is 
that items that are next to each other are likely to be connected to each 
other conceptually. The last three items: `mushrooms, Beef tenderloin, Puff pastry`
are all ingredients for a Beef Wellington recipe. If the store happens
to be all out of puff pastry, it might make sense to skip the
mushrooms and the beef, since you can't make the recipe.

Okay, so a grocery list has an ordering that's sometimes relevant. 

Here's a slightly philosophical question: Was the grocery list a list
before someone added the first item (`Milk`) to it?

In common language, we probaby wouldn't call a blank piece of paper a list.
But we could perhaps call a piece of paper with the title `Grocery List` at the
top a "blank grocery list", or an "empty grocery list", although that might
sound strange.

In Haskell-land (and CS-country in general), an empty list is definitely a 
list. `List` in Haskell is defined as follows:

```haskell
data List a = Nil | Cons a (List a)
```

`Nil` is the empty list. We build lists by connecting the items in the list
to each other and ultimately to the empty list. So the above definition says roughly:
"A list of `a` is either an empty list, or is the connection of an `a` to a `List` of `a`.

Since `a` is just a stand-in for some type of thing, a list of
groceries in Haskell would be:

```haskell
data List Grocery = Nil | Cons Grocery (List Grocery)
```

"A list of groceries is either an empty list, or is the connection of a grocery item
to a list of groceries."

If `Milk`, `Eggs` and `Flour` are all of the type `Grocery`, then we can 
make the following Grocery list:

```haskell
aGroceryList = Cons Milk (Cons Eggs (Cons Flour Nil))
```

This looks a litlle complicated though, so in Haskell, `Cons` represented
as the `:` operator and `Nil` is `[]`.

```haskell
aNicerGroceryList = Milk:Eggs:Flour:[]
```

But the syntactic sugar goes even a step further.

```haskell
theNicestGroceryList = [Milk, Eggs, Flour]
```

At the REPL:

```haskell
Prelude> data Grocery = Milk | Eggs | Flour deriving Show
Prelude> Milk:Eggs:Flour:[]
[Milk,Eggs,Flour]
Prelude> :type [Milk,Eggs,Flour]
[Milk,Eggs,Flour] :: [Grocery]
```

That last line means that the type of `[Milk,Eggs,Flour]` is a `[Grocery]`,
which means the same as `List Grocery`.

`[]` is the list constructor in Haskell, which we can see at the REPL

```haskell
Prelude> :info []
data [] a = [] | a : [a] 	-- Defined in ‘GHC.Types’
```

There's some overloading of `[]` here, since `[]` is representing both `List`
and `Nil`, but in practice this is nice since you build a list of `a`, `[a]`,
by consing `a` to `nil`, `a:[]`.


### Char

A `Char` is an ASCII character ([American Standard Code for Information Interchange](
https://en.wikipedia.org/wiki/ASCII)). 

[NB. `Char` actually represents Unicode characters in general, but I don't want
to bring in Unicode as a conceptual dependency here]

Ascii is a way to represent text characters as numbers.  Here's a table of all
128 ascii characters:

```
Dec  Char                           Dec  Char     Dec  Char     Dec  Char
---------                           ---------     ---------     ----------
  0  NUL (null)                      32  SPACE     64  @         96  `
  1  SOH (start of heading)          33  !         65  A         97  a
  2  STX (start of text)             34  "         66  B         98  b
  3  ETX (end of text)               35  #         67  C         99  c
  4  EOT (end of transmission)       36  $         68  D        100  d
  5  ENQ (enquiry)                   37  %         69  E        101  e
  6  ACK (acknowledge)               38  &         70  F        102  f
  7  BEL (bell)                      39  '         71  G        103  g
  8  BS  (backspace)                 40  (         72  H        104  h
  9  TAB (horizontal tab)            41  )         73  I        105  i
 10  LF  (NL line feed, new line)    42  *         74  J        106  j
 11  VT  (vertical tab)              43  +         75  K        107  k
 12  FF  (NP form feed, new page)    44  ,         76  L        108  l
 13  CR  (carriage return)           45  -         77  M        109  m
 14  SO  (shift out)                 46  .         78  N        110  n
 15  SI  (shift in)                  47  /         79  O        111  o
 16  DLE (data link escape)          48  0         80  P        112  p
 17  DC1 (device control 1)          49  1         81  Q        113  q
 18  DC2 (device control 2)          50  2         82  R        114  r
 19  DC3 (device control 3)          51  3         83  S        115  s
 20  DC4 (device control 4)          52  4         84  T        116  t
 21  NAK (negative acknowledge)      53  5         85  U        117  u
 22  SYN (synchronous idle)          54  6         86  V        118  v
 23  ETB (end of trans. block)       55  7         87  W        119  w
 24  CAN (cancel)                    56  8         88  X        120  x
 25  EM  (end of medium)             57  9         89  Y        121  y
 26  SUB (substitute)                58  :         90  Z        122  z
 27  ESC (escape)                    59  ;         91  [        123  {
 28  FS  (file separator)            60  <         92  \        124  |
 29  GS  (group separator)           61  =         93  ]        125  }
 30  RS  (record separator)          62  >         94  ^        126  ~
 31  US  (unit separator)            63  ?         95  _        127  DEL
```

Most of the first 32 are control characters intended for use by teletype machines
and magnetic tape readers, so you don't have to worry about them. A
few are still used though, `\n` in Haskell means newline and is the same
as Ascii 10 `\LF`.

We can see the correspondence at the REPL:

```haskell
Prelude> import Data.Char
Prelude Data.Char> ord 'a'
97
Prelude Data.Char> chr 97
'a'
Prelude Data.Char> :type ord
ord :: Char -> Int
Prelude Data.Char> :type chr
chr :: Int -> Char
Prelude Data.Char> map ord "foobar"
[102,111,111,98,97,114]
Prelude Data.Char> map chr [102,111,111,98,97,114]
"foobar"
```

### Strings II

A String is just a list of `Char`, or `[Char]`:

```haskell
Prelude> :info String
type String = [Char] 	-- Defined in ‘GHC.Base’
```

The double quotes in "foobar" are just syntactic sugar for:

```haskell
Prelude> ['f','o','o','b','a','r']
"foobar"
```


## 3.4 Top-level versus local definitions 

### Exercises: Scope

1. `y` is in scope for `z`
2. `h` is not in scope for `g`
3. `pi` is in scope, since it's in Prelude, but `d` is not in scope for 
the definition of `r`. `d` is an argument in `area` but `r` can't see into
`area`'s definition.
4. This fixes what was wrong in the previous question. The `where` clause means
that `r` can access `area`'s arguments. However, `r` is now locally defined to
`area`, so another top level function wouldn't be able to see it.

## 3.5 Types of concatenation functions 

### Exercises: Syntax Errors
1. Need `(++)` not `++`
2. Single quotes are type `Char` not type `String`
3. This one works.

## Chapter Exercises

### Reading syntax:

1.  a. correct
    b. not correct, need `(++)` not `++`
    c. correct
    d. incorrect, string not closed
    e. incorrect, wrong arg order
    f. correct
    g. incorrect, no integer argument
    h. correct

2.  a. d
    b. c
    c. e
    d. a
    e. b

### Building Functions:

1.  a. `(++ "!")`
    b. `(!! 4)`
    c. `(drop 6)`

2.  ```haskell
    module Exercise2 where
    a = (++ "!")
    b = (!! 4)
    c = (drop 6)
    ```

3.  ```haskell
    module Exercise3 where

    thirdLetter :: String -> Char
    thirdLetter x = x !! 2
    ```
4.  ```haskell
    module Exercise4 where

    letterIndex :: Int -> Char
    letterIndex x = "Curry is awesome" !! x
    ```

5.  ```haskell
    module Reverse where
    rvrs :: String -> String
    rvrs x = third ++ second ++ first where
             third = drop 9 x
             second = take 4 $ drop 5 x
             first = take 5 x

    main :: IO ()
    main = print $ rvrs "Curry is awesome"
    ```
6. see exercise 5.

---

# 4 Basic Datatypes

## 4.2 What are types?

**Types**: Haskell has expressions. Type the number `1` into the repl.
That's an expression. Type `addOne = (+) 1`. The function `addOne` is also
an expression. Try to imagine all the possible expressions we could type into
GHCi. This is hard to do because the number of possibile expressions is
infinite.  But if we try to imagine lots of different expressions, we should
start to notice patterns. `1` is an expression, so is `2`, so is `3`, and 
so on. All positive integers are expressions. `-1` is an expression, so `-2`
and `-3`. Negative integers, and therefore all integers are expressions.
The pair `(1,1)` is an expression, so is `(1,2)`, so is `(23,58982)`. All pairs of integers
are expressions. We can keep going like this forever, finding new patterns
of ways to group expressions together. Every time we find a new expression-pattern,
if we can precisely describe the structure of that pattern, we have a type. 

When we played with the `String` type in the preceeding chapter, we were,
in effect, saying "Let's for the moment
think about only those expressions that have the `String` pattern, which looks
like this:

```haskell
data String = [Char]
data [] a = [] | a : [a]
``

Haskell mandates that expressions have types, and the compiler will not
let us run code where the types do not match up.

Try running:

```haskell
Prelude> not "foo"

<interactive>:4:5: error:
    • Couldn't match expected type ‘Bool’ with actual type ‘[Char]’
    • In the first argument of ‘not’, namely ‘"foo"’
      In the expression: not "foo"
      In an equation for ‘it’: it = not "foo"
Prelude> :type not
not :: Bool -> Bool
```

`not` is a function which takes a `Bool` and returns a `Bool`. If we
try to call `not` with a `String` we get a type error. Our expression
was not "well-typed."

We can also define new patterns, like 

```haskell
data Grocery = Milk | Eggs | Flour
```

So the type system is a tool for defining new patterns in the space
of possible expressions, and then checking that in the code we want to 
run, all the types fit together perfectly.

If you have ever played with Legos, you already have an intuition for 
how this ought to work.

<p align="center">
<img
src="https://upload.wikimedia.org/wikipedia/commons/3/32/Lego_Color_Bricks.jpg"
width = 400px
alt="Legos">
</p>

There are a lot of different ways to fit Lego' together. Two standard two by
four Lego bricks of the same color can be combined 24 ways (ignoring
symmetries). But there are also a lot of ways that you can't fit pieces
together. You can't, for example, place a brick on top of two adjacent bricks
at different heights. No amount of force will get the pieces to bend (Lego's are
very tough) that way. You can't "coerce" Lego's into doing whatever you want.
The shapes are what they are, and it's up to you the builder to figure out 
some interesting way to fit them together.

Haskell expressions are like Lego pieces. And types are like their shapes. 
But unlike with Lego's, you get to design entirely new pieces, as well 
as put them together.

## 4.3 Anatomy of a data declaration

In the data declaration:

```haskell
data Bool = False | True
```

It's important to keep in mind that everything to left of the `=` are
types, and everything to the right are expressions.

```haskell
Prelude> data Bool = False | True deriving Show
Prelude> False
False
Prelude> Bool

<interactive>:6:1: error: Data constructor not in scope: Bool
Prelude> :type False
False :: Bool
Prelude> :info Bool
data Bool = False | True 	-- Defined at <interactive>:4:1
instance [safe] Show Bool -- Defined at <interactive>:4:35
Prelude>
```

`Bool` and `False` live in two different spaces. `Bool` lives in type-space
and `False` lives in data-space. This is a really important distinction!
Typespace disappears after code gets compiled, so you can't interact with
them in running code (or "runtime").

**compile-time**: When code gets compiled. Types are used in compiletime,
but not in runtime. Compiler errors happen at compile-time.

**run-time**: When code gets run. Haskell types vanish at run-time. A run-time
error might be an exception like:

```haskell
Prelude> head []
*** Exception: Prelude.head: empty list
```

Another thing to remember is that since typespace and dataspace are distinct,
the same name can live in both spaces:

```haskell
Prelude> data Thing a = Thing a deriving Show
Prelude> Thing 1
Thing 1
Prelude> Thing 1 :: Thing Integer
Thing 1
```

`Thing` the data constructor lives in dataspace:

```haskell
Prelude> :t Thing
Thing :: a -> Thing a
```

And `Thing` the type constructor lives in typespace:

```haskell
Prelude> :i Thing
data Thing a = Thing a 	-- Defined at <interactive>:24:1
instance [safe] Show a => Show (Thing a)
  -- Defined at <interactive>:24:33
```

But this is just two names that happen to be the same. We could equivalently
say:
```haskell
Prelude> data Thing a = MakeThing a deriving Show
```
and everything behaves the same:

```haskell
Prelude> data Thing a = MakeThing a deriving Show
Prelude> Thing 1

<interactive>:5:1: error:
    Data constructor not in scope: Thing :: Integer -> t
Prelude> MakeThing 1
MakeThing 1
Prelude> :t Thing 

<interactive>:1:1: error: Data constructor not in scope: Thing
Prelude> :t MakeThing 
MakeThing :: a -> Thing a
Prelude> :i Thing
data Thing a = MakeThing a 	-- Defined at <interactive>:4:1
instance [safe] Show a => Show (Thing a)
  -- Defined at <interactive>:4:37
Prelude> 
```

### Exercises: Mood Swing
1. `Mood`
2. `Blah` or `Woot`
3. Woot is a value whose type is Mood, should be `changeMood :: Mood -> Mood`
4.  ```haskell
    -- Mood.hs
    module Mood where
    data Mood = Woot | Blah deriving Show
    
    changeMood :: Mood -> Mood
    changeMood Blah = Woot
    changeMood Woot = Blah
    ```
5. see 4.

## 4.4 Numeric types

Numeric types will not completely make sense without typeclasses.

**Typeclass**: A collection of types that share common properties.
For example, the typeclass `Show` is defined as

```haskell
Prelude> :i Show
class Show a where
  showsPrec :: Int -> a -> ShowS
  show :: a -> String
  showList :: [a] -> ShowS
  {-# MINIMAL showsPrec | show #-}
  	-- Defined in ‘GHC.Show’
```

Which is for our purposes equivalent to:

```haskell
class Show a where
  show :: a -> String
```
So any type that is an instance of `Show` has a function called `show`
that lets you turn a value of that type into a `String`.

Let's try it:

```haskell
Prelude> data Something = Something
Prelude> instance Show Something where show Something = "Something"
Prelude> show Something
"Something"
```

Of course, this is tedious, so Haskell gives us a `deriving` mechanism
that does effectively this:

```haskell
Prelude> data Something = Something deriving show
Prelude> show Something
"Something"
```

The reason this is relevant is that `Num`, `Fractional` and `Integral` are
all typeclasses, not types:

```
Prelude> :i Num
class Num a where
  (+) :: a -> a -> a
  (-) :: a -> a -> a
  (*) :: a -> a -> a
  negate :: a -> a
  abs :: a -> a
  signum :: a -> a
  fromInteger :: Integer -> a
  {-# MINIMAL (+), (*), abs, signum, fromInteger, (negate | (-)) #-}
  	-- Defined in ‘GHC.Num’
Prelude> :i Fractional
class Num a => Fractional a where
  (/) :: a -> a -> a
  recip :: a -> a
  fromRational :: Rational -> a
  {-# MINIMAL fromRational, (recip | (/)) #-}
  	-- Defined in ‘GHC.Real’
Prelude> :i Integral
class (Real a, Enum a) => Integral a where
  quot :: a -> a -> a
  rem :: a -> a -> a
  div :: a -> a -> a
  mod :: a -> a -> a
  quotRem :: a -> a -> (a, a)
  divMod :: a -> a -> (a, a)
  toInteger :: a -> Integer
  {-# MINIMAL quotRem, toInteger #-}
  	-- Defined in ‘GHC.Real’
```

But this is getting pretty deep into the "typeclass zoo." Better leave this
for chapters 5 and 6.

## 4.6 Go on and Bool me

### Exercises: Find the Mistakes

1. `not True && True`
2. `not (x == 6) where x = 5`
3. `(1 * 2) > 5`
4. `["Merry"] > ["Happy"]`
5. `["1, 2, 3"] ++ "look at me!"`


## 4.9 Chapter Exercises

1. `length :: [a] -> Int`

2.  a. 5
    b. 3
    c. 2
    d. 5

3. `Int` is not a `Fractional`
4. Use infix ```div` `` instead
5. `Bool`, returns `True`
6. `Bool`, returns `False`
7.  a. Works, `False`
    b. Error, no instance `(Num Char)`
    c. Works, returns `8`
    d. Works returns `False`
    e. No instance `(Num Bool)`

8.  ```haskell
    isPalindrome :: (Eq a) => [a] -> Bool
    isPalindrome x = reverse x == x
    ```

9.  ``` haskell
    myAbs :: Integer -> Integer
    myAbs = if x < 0 then (-x) else x
    ```

10.  ```haskell
     -- Exercise10.hs
     module Exercise10 where

     f :: (a, b) -> (c, d) -> ((b, d), (a, c))
     f x y = ((snd x, snd y), (fst x, fst y))
     ```

### Correcting syntax

1.  ```haskell
    -- CorrectingSyntax1.hs
    module CorrectingSyntax1 where

    f xs = length xs + 1
    ```
2.  ```haskell
    -- CorrectingSyntax2.hs
    module CorrectingSyntax2 where

    f = (\x -> x)
    ```
3.  ```haskell
    -- CorrectingSyntax3.hs
    module CorrectingSyntax3 where

    f (a, b) = a
    ```

### Match the function names to their types

1.  c
2.  b
3.  a
4.  d

---

## 5 Types

I want to acknowledge how apt and lovely the quote at the beginning of this
chapter is. It is an excerpt from the Wallace Stevens poem: [The Idea of Order
at Key West](https://www.poetryfoundation.org/poems/43431/the-idea-of-order-at-key-west)

## 5.3 How to read type signatures


The type constructor for function `(->)` isn't magic. It's exactly like
any other type constructor. Recall how previously with lists the type constructor
was `[]`:

```haskell
Prelude> :i []
data [] a = [] | a : [a] 	-- Defined in ‘GHC.Types’
```

There isn't any reason other than cleaner syntax that `[] a` or `[a]` couldn't
be `List a`.

Well the function type is almost exactly the same. There isn't any reason
why `a -> b`, which is `(->) a b`, couldn't be `Fun a b`. It's just more 
syntactic sugar (Haskell is a very sugary language. That's why it's so sweet!)

```haskell
Prelude> :i (->)
data (->) t1 t2 	-- Defined in ‘GHC.Prim’
infixr 0 `(->)`
```

There isn't any definiiton for the function type though because it's a 
primitive (hence the `GHC.Prim`).

### Exercises: Type Matching

1.  a. `not :: Bool -> Bool`
    b. `length :: [a] -> Int`
    c. `concat :: [[a]] -> [a]`
    d. `head :: [a] -> a`
    e. `(<) :: Ord a => a -> a -> Bool`


## 5.4 Currying

All these types for `f` are equivalent:

```haskell
type Fun = (->)
f :: a -> a -> a
f :: a -> (a -> a)
f :: (->) a ((->) a a)
f :: Fun a (Fun a a)
```

Functions in Haskell return one and only one thing. Partial application
is kind of a silly term. What's partial about applying a `Fun a (Fun a a)` to
an `a`? You give it an `a`, it gives you a function. Nothing partial about
that. Maybe we wanted a function.

It's only partial if you think of functions of somehow not being final values.
Which is how they are in imperative-land. But we're not in imperative-land 
anymore. Here functions are first-class, so they actually are values like
anything else.

In fact, if you remember any of Chapter 1, there's a good argument to be made
that functions are more real than any other value. Lambda calculus builds
the whole universe out of functions. Sure literals exist, but they're
a convenience (a huge convenience) not a strict necessity.

The `curry` and `uncurry` functions in the text are useful to understand
conceptually. 

Sectioning is basically bad practice. It's a great way to confuse yourself
and others. Do yourself a favor and throw an abstraction on top of it:

Not 
```
y = (2^)
z = (^2)
```

But rather,
```
y = \x -> 2^x
z = \x -> x^2
```

You see how much nicer that is? Don't abuse infix operators please. They're
there to make text more legible, not more terse and inscrutable. There are
definitely cases where a clever sectioning of an infix operator can make things
clearer. These cases are exceptions. 

### Exercises: Type Arguments 

1. a 
2. d
3. d
4. c
5. a
6. e
7. e
8. e
9. c

## 5.5 Polymorphism

Greek words abound in Haskell jargon. If we lived in an age that believed
in proper education you would already know them. We do not live in such an 
age. 

Important words:

```
hyle: matter
morphe: form

polys: - many
monos: - one

autos: self
endon: in
ectos: out
isos: equal

ana: up
kata: down
epi:  upon
meta: beyond, with
para: beside
meter: measure
```

So when you read "parameteric polymorphism", fear not, you are really
reading "beside-measure many-form-thing." The latter doesn't sound nearly
as clever at cocktail parties, but that's actually what the words mean,
and knowing the meanings of the words you use helps you remember the 
concepts they describe.

A parameter is quite literally a "side measure." When we measure
a thing by looking at it next to something else, we're using a parameter.
Ever ask whether something was bigger than a breadbox? That's measuring
size in terms of breadboxes. It's a side measures. It's a parameter.


## Exercises: Parametricity

1. This is impossible because id has to work for a type that only one member.
   If a type only has one member, then the only thing a function with 
   signature a -> a can do if passed a value of that type is return the same
   value (or bottom, which is in every type) without breaking the type
   signature.
2. `f x y = x` or `f x y = y`
3. `a -> b -> b` is the same as `a -> (b -> b)` and the only thing with type
   `(b -> b)` is the id function. So this function is a kind of constant
   function that takes two arguments and returns the second, as opposed to 
   `const :: a -> b -> a` which takes two arguments and returns the first.
   One implementation would be `const id`, but I am unsure whether `flip const`
   counts as a separate implementation.

## 5.6 Type Inference

Type inference is a cool tool for helping us build better programs. But 
it works best when you give it annotations to infer from. A lot of Haskell
programming involves defining the types of the top-level expressions in your
program before you actually start constructing anything, so this isn't exactly
any extra work.

And if you want to see real type system magic at work:
[Typing the technical interview](https://aphyr.com/posts/342-typing-the-technical-interview)


### Exercises: Apply Yourself

1. `[Char] -> [Char]`
2. `Fractional a => a -> a`
3. `Int -> [Char]`
4. `Int -> Bool`
5. `Char -> Bool`



## 5.8 Chapter Exercises

### Multiple Choice
1. c
2. a
3. b
4. c

### Determine the type:

1.  a. `Num a => a`
    b. `Num a => (a, [Char])`
    c. `(Integer, [Char])`
    d. `Bool`
    e. `Int`
    f. `Bool`

2. `Num a => a`
3. `Num a => a -> a`
4. `Fractional a => a`
5. `[Char]`

### Does it compile?:

1. `bignum $ 10` doesn't make sense `5^10` is a number not a function
2. This should work.
3. c and d need a function.
4. c not in scope.

### Type variable or specific type constructor?

1. 
- 0: constrained polymorphic type var
- 1: fully polymorphic type var
- 2: concrete
- 3: concrete

2. 
- 0: fully polymorphic
- 1: concrete
- 2: concrete

3. 
- 0: fully polymorphic
- 1: constrained polymorphic
- 2: concrete

4. 
- 0: fully polymorphic 
- 1: fully polymorphic
- 2: concrete

### Write a type signature:

1. `[a] -> a`
2. `(Ord a, Ord b) => a -> b -> Bool`
3. `(a, b) -> b`

### Given a type, write the function:

1. `i = id`
2. `c x y = x`
3. `yes`
4. `c' x y = y`
5. `r = tail`
6. `co x y z = x $ y z`
7. `a x y = fst(y, x y)`
8. `a' x y = x y`

### Fix it

1.  ```haskell
    module Sing where

    fstString :: String -> String
    fstString x = x ++ " in the rain"

    sndString :: String -> String
    sndString x = x ++ " over the rainbow"

    sing = if (x > y) then fstString x else sndString y where 
           x = "Singin"
           y = "Somewhere"
    ```
2.  ```haskell
    module Sing where

    fstString :: String -> String
    fstString x = x ++ " in the rain"

    sndString :: String -> String
    sndString x = x ++ " over the rainbow"

    sing = if (x < y) then fstString x else sndString y where 
           x = "Singin"
           y = "Somewhere"
    ```
3.  ```haskell
    module Arith3Broken where

    main :: IO ()
    main = do
      print $ 1 + 2
      print 10 
      print $ negate (-1)
      print $ 0 + blah
      where blah = negate 1
    ```

### Type-Kwon-Do

1. `h x = g $ f x`
2. `e x = w $ q x`
3. `xform (x, y) = (xz x, yz y) `
4. `munge f g x = fst $ g $ f x`


## 5.10 Follow-up resources

1. Luis Damas; Robin Milner. Principal type-schemes for func-
tional programs

2. Christopher Strachey. Fundamental Concepts in Programming
Languages
Popular origin of the parametric/ad-hoc polymorphism dis-
tinction.

---

# 6 Typeclasses

## 6.2 What are typeclasses?

"Typeclasses and types in Haskell are, in a sense, opposites". 

Sentences like these frustrate me. You can say nearly anything is the case
"in a sense:"

"In a sense, the Moon really is made of cheese." In the sense of poetic whimsy.

"In a sense, Johnny is at the top of his class." In unexcused absences and
missed assignments.

This is just some plain old fashioned jesuitical casuistry. Annoying.

"In a sense, typeclasses and types are the same." In the sense that they both
specify and constrain the properties of expressions.

If an expression's type is an instance of `Eq` it means there's a way to 
define to define and equals function `(==)` to check if two expressions
of that type are equal:

```
Prelude> :info Eq
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
  	-- Defined in ‘GHC.Classes’
```

But there are types that it is impossible to define `(==)` for! The 
function constructor `(->)`, for example, cannot be an instance of `Eq`. Why?
The Halting Problem! If there's no general way to test whether a function 
will halt on a given input, there's certainly no general way to determine
whether two functions will do the same thing (run forever or return the 
same value) for a given input.

So typeclasses constrains the potential things types can be by specifying
what they can do.

Some typeclasses and their relationships:

<p align="center">
<img
src="https://wiki.haskell.org/wikiupload/d/df/Typeclassopedia-diagram.png"
width = 600px
alt="Typeclassopedia">
</p>

## Exercises: Eq Instances

1.  ```
    instance Eq TisAnInteger where (==) TisAn x TisAn y = (==) x y
    ```
2.  ```
    instance Eq TwoIntegers where Two x y == Two p q = (x, y) == (p, q)
    ```

3.  String or Int:

    ```
    instance Eq StringOrInt where 
    TisAnInt x == TisAnInt y = x == y
    TisAString x == TisAString y = x == y
    _ == _ = False
    ```
4.  ```
    instance Eq Pair where Pair a b == Pair x y = (a, b) == (x, y)
    ```

5.  ```
    instance Eq Tuple where Tuple a b == Tuple x y = (a, b) == (x, y)
    ```

6.  Which
 
    ``` 
    instance Eq a => Eq (Which a) where 
    ThisOne x == ThisOne y = x == y
    ThatOne x == ThatOne y = x == y
    _ == _ = False
    ```

7.  EitherOr

    ```
    instance (Eq a, Eq b) => Eq (EitherOr a b) where 
    Hello x == Hello y = x == y
    Goodbye x == Goodbye y = x == y 
    _ == _ = False
    ```
 
## Exercises: Tuple Experiment

`quotRem` and `divMod` return a tuple with the values from `quot` and `rem` or 
`div` and `mod` respectively.

## Exercises: Will They Work?

1. `5`
2. `LT`
3. error, a string and a bool are not comparable
4. `False`

## Chapter Exercises

### Multiple choice

1. c
2. b
3. a
4. c
5. a

### Does it typecheck?:

1.  ch6/ex1.hs 
2.  ch6/ex2.hs

3.  a. any `Mood`, i.e. `Blah` or `Woot`
    b. type error, `9` is not a `Mood`
    c. `Mood` does not derive `Ord`

4.  ch6/ex4.hs

### Given a datatype declaration, what can we do?
exdatatype.hs

1. `"chases"` and `True` are a `String` and a `Bool`, not a `Rocks` and a `Yeah`
2. works
3. works
4. `Papu` isn't an instance of `Ord`

### Match the types:

exmatch1.hs and exmatch2.hs

1. Since `i = 1`, `i` has to be a `Num`, it can't be a type that `1` isn't,
like e.g.  a `String`. We can't cast `i` upwards.
2. `1.0` is not just any instance of `Num`, the syntax implies `Fractional`.
3. works
4. works
5. works, we can always cast downwards
6. works
7. Doesn't work, `sigmund` returns `myX` which is an `Int`
8. Doesn't work, `sigmund'` returns an `Int` not any instance of `Num`
9. Works, restricts `jung` to a list of `Ints` rather than any list
10. Works, restricts input to `String`
11. Doesn't work, `mySort` only sorts `Strings`, not any instance of `Ord`

### Type-Kwon-Do: Electric Typealoo

1. `chk f a b = f a == b`
2. `arith f n a = (+ fromIntegral n) (f a)`

## 6.17 Follow-up resources

1. [P. Wadler and S. Blott. How to make ad-hoc polymorphism less
ad hoc.] (http://www.cse.iitk.ac.in/users/karkare/courses/2010/cs653/Papers/
ad-hoc-polymorphism.pdf)

2. [Cordelia V. Hall, Kevin Hammond, Simon L. Peyton Jones, and Philip L.
Wadler. Typeclasses in Haskell.] (http://ropas.snu.ac.kr/lib/dock/HaHaJoWa1996.pdf)


# 7 More functional patterns 

## 7.2 Arguments and parameters

This section is best understood in the context of the lambda calculus. I
recommend reading at least [chapter 1 of my notes on Rojas' Introduction to
the Lambda Calculus](/posts/workthrough-lambda-calculus-rojas.html#definition).

## 7.3 Anonymous functions

### Exercises: Grab bag

1.  They are all equivalent
2.  d
3.  a. `f = \x -> x + 1`
    b. `addFive = \x -> \y -> (min x y) + 5`
    c. `mflip f x y = f y x`

## 7.4 Pattern matching

From [Gonzalez's "How to Desugar Haskell Code"](https://github.com/johnchandlerburnham/hpffp-resources/blob/master/Chapter-02/How%20to%20desugar%20Haskell%20code.pdf)

> Pattern matching on constructors desugars to case statements:
>
> ```haskell
> f (Left  l) = eL
> f (Right r) = eR
> 
> -- ... desugars to:
>
> f x = case x of
>     Left  l -> eL
>     Right r -> eR
> ```
> 
> Pattern matching on numeric or string literals desugars to equality tests:
> 
> ```haskell
> f 0 = e0
> f _ = e1
> 
> -- ... desugars to:
> f x = if x == 0 then e0 else e1
> 
> -- ... desugars to:
> f x = case x == 0 of
>     True  -> e0
>     False -> e1
> ``` 


### Exercises: Variety Pack

1.  a. `k :: (a, b) -> a`
    b. `k2` is a `String`, not the same as `k1` or `k3`
    c. `k1` and `k3`

2.  `f (a, b, c) (d, e, f) = ((a, d), (c, f))`

## 7.5 Case expressions

### Exercises: Case Practice

1.  ```
    functionC x y = case (x > y) of
      True -> x 
      False -> y 
    ```

2.  ```
    ifEvenAdd2 n = 
      case even n
        True -> (n + 2)
        False -> n
    ```

3.  ```
    nums x = 
      case compare x 0 of
        LT -> -1
        GT -> 1
        EQ -> 0
    ```

## 7.6 Higher-order functions

### Exercises: Artful Dodgy 

2. `11`
3. `22`
4. `21`
5. `12`
6. `11`
7. `21`
8. `21`
9. `22`
10. `31`
11. `23`

## 7.7 Guards

### Exercises: Guard Duty

```haskell
--07/AvgGrade.hs
module AvgGrade where

avgGrade :: (Fractional a, Ord a) => a -> Char
avgGrade x
  | y >= 0.7 = 'C'
  | y >= 0.9 = 'A'
  | y >= 0.8 = 'B'
  | y >= 0.59 = 'D'
  | otherwise = 'F'
  where 
    y = x / 100  
```

1. Can't do otherwise if theres no wise to other. 
2. No, because the conditions are not exclusive.
3. b
4. anything reversible, so lists
5. `[a] -> Bool`
6. c
7. `(Ord a, Num a) => a`
8. `(Ord a, Num a) => a -> Bool`


## 7.11 Chapter Exercises

### Multiple Choice

1. d
2. b
3. a
4. b
5. a

### Let's write code

1.  a.  `tensDigit x = (flip mod) 10 $ fst $ divMod x 10`
    
        Seems silly to use `divMod`, when

        `tensDigit' x = (flip mod) 10 $ div x 10`

        works perfectly well.


    b.  Yup. 

    c.  Well let's do this properly:

        ```haskell
        -- 07/Digit.hs

        baseDigit :: Integral a => a -> a -> a -> Maybe a
        baseDigit base digit x
          | base == 0 = Nothing
          | digit < 0 = Nothing
          | otherwise = Just $ (flip mod) base $ div x (base ^ digit)
        ```
       
        So that 
        
        ```haskell
        *Main> baseDigit 10 2 1234
        Just 2
        *Main> baseDigit 10 2 123456
        Just 4
        *Main> baseDigit 10 2 9876543210
        Just 2
        *Main> 
        ```

2.  ```haskell
    -- 07/FoldBool.hs
                                                                                   
    foldBool :: a -> a -> Bool -> a
    foldBool x y b = case b of
       True -> x
       False -> y

    foldBool2 :: a -> a -> Bool -> a
    foldBool2 x y b
     | b == True = x
     | b == False = y
    ```

3. `g f (a, b) = (f a, b)`

4.  ```haskell
    -- 07/arith4.hs

    roundTrip :: (Show a, Read a) => a -> a
    roundTrip a = read (show a)

    roundTripPF :: (Show a, Read a) => a -> a
    roundTripPF = (read . show)

    roundTrip2 :: (Show a, Read b) => a -> b
    roundTrip2 a = read (show a)

    main = do
      print (roundTrip2 (4 :: Int))
      print (id 4)
    ```
   
## 7.13 Follow-up resources

1. [Paul Hudak; John Peterson; Joseph Fasel. A Gentle Introduction
to Haskell, chapter on case expressions and pattern matching.](https://www.haskell.org/tutorial/patterns.html)

2. [Simon Peyton Jones. The Implementation of Functional Pro-
gramming Languages, pages 53-103.](http://research.microsoft.com/en-us/um/people/simonpj/papers/slpj-book-1987/index.htm)

3. [Christopher Strachey. Fundamental Concepts in Programming
Languages, page 11 for explanation of currying.](http://www.cs.cmu.edu/~crary/819-f09/Strachey67.pdf)
4. [J.N. Oliveira. An introduction to pointfree programming.](http://www.di.uminho.pt/~jno/ps/iscalc_1.ps.gz)
5. [Manuel Alcino Pereira da Cunha. Point-free Program Calculation.](http://www4.di.uminho.pt/~mac/Publications/phd.pdf)

# 8 Recursion

## 8.2 Factorial

## Intermission: Exercise

```
applyTimes 5 (+1) 5
```
turns  into

```
((+1) . (+1) . (+1) . (+1) . (+1)) 5
```

## 8.6 Chapter Exercises

### Review of types

1. d
2. b
3. d
4. b

### Reviewing currying

```haskell
flippy :: String -> String -> String
appedCatty :: String -> String
frappe :: String -> String
```

1. `"woops mrow woohoo"`
2. `"1 mrow haha"`
3. `"woops mrow 2 mrow haha"`
4. `"woops mrow blue mrow haha"`
5. `"pink mrow haha mrow green mrow woops mrow blue"`
6. `"are mrow Pugs mrow awesome"`

### Recursion

1.  ```
    dividedBy 15 2 -> 
    go 15 2 0 -> 
    go 13 2 1 -> 
    go 11 2 2 -> 
    go 9 2 3 ->
    go 7 2 4 -> 
    go 5 2 5 -> 
    go 3 2 6 -> 
    go 1 2 7 -> 
    (7, 1)
    ```

2.  ```haskell
    -- 08/rsum.hs
    rsum :: (Eq a, Num a) => a -> a
    rsum n = go n 0
      where 
        go n c
         | n == 0 = c
         | otherwise = go (n - 1) (c + n)
    ```

3.  ```haskell
    -- 08/rmult.hs
    rmult :: (Integral a) => a -> a -> a
    rmult a b = go a b 0
      where 
        go a b c
         | b == 0 = c
         | otherwise = go a (b - 1) (c + a)
    ```

### Fixing dividedBy:

```haskell
-- 08/DividedBy.hs
module DividedBy where

unsafeDividedBy :: Integral a => a -> a -> (a, a)
unsafeDividedBy num denom = go num denom 0
  where 
    go n d count
      | n < d = (count, n)
      | otherwise = go (n - d) d (count + 1)

-- div throws an exception on zero
partialDividedBy :: Integral a => a -> a -> (a, a)
partialDividedBy num denom = go num denom 0
  where 
    go n d count
      | n < d = (count, n)
      | d < 0 = go n (negate d) count
      | d == 0 = error $ "can't div by zero"
      | otherwise = go (n - d) d (count + 1)


data DividedResult = Result Integer | DividedByZero deriving (Eq, Show)
-- equivalent to Maybe Integer

dividedBy :: Integral a => a -> a-> DividedResult
dividedBy num denom = go num denom 0
  where 
    resNeg (Result x) = Result (negate x)
    go n d count
      | d == 0 = DividedByZero
      | d < 0 = resNeg $ go n (negate d) count 
      | n < 0 = resNeg $ go (negate n) d count 
      | n < d = Result count
      | otherwise = go (n - d) d (count + 1)
```

### McCarthy 91 function:

```haskell
-- 08/mccarthy91.hs
mc91 :: Integral a => a -> a
mc91 n
  | n > 100 = n - 10 
  | otherwise = (mc91 . mc91) (n + 11)
```

### Numbers into Words: 

```haskell
-- 08/WordNumber.hs
module WordNumber where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord x = 
  case x of 
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    0 -> "zero"
    _ -> "NaD"

digits :: Int -> [Int]
digits n = go n []
  where go n d
          | n < 10 = n:d
          | n >= 10 = go (n `div` 10) $ (n `mod` 10):d
          
wordNumber :: Int -> String
wordNumber n = concat $ intersperse "-" $ map digitToWord $ digits n
```

# 9 Lists

## 9.5 Using ranges to construct lists

### Exercise: EnumFromTo

```haskell
--09/EnumFromTo.hs

module EnumFromTo where

-- the exercises for specific types

eftBool:: Bool -> Bool -> [Bool]
eftBool x y = go x y []
  where 
    go a b c
      | a > b = c
      | a == b = reverse (a : c)
      | otherwise = go (succ a) b (a : c)

eftInt:: Int -> Int -> [Int]
eftInt x y = go x y []
  where 
    go a b c
      | a > b = c
      | a == b = reverse (a : c)
      | otherwise = go (succ a) b (a : c)

eftOrd:: Ordering -> Ordering -> [Ordering]
eftOrd x y = go x y []
  where 
    go a b c
      | a > b = c
      | a == b = reverse (a : c)
      | otherwise = go (succ a) b (a : c)

eftChar:: Char -> Char -> [Char]
eftChar x y = go x y []
  where 
    go a b c
      | a > b = c
      | a == b = reverse (a : c)
      | otherwise = go (succ a) b (a : c)

-- these all look basically the same, so let's generalize:

eft :: (Ord a, Enum a) => a -> a -> [a]
eft x y = go x y []
  where 
    go a b c
      | a > b = c
      | a == b = reverse (a : c)
      | otherwise = go (succ a) b (a : c)

-- that reverse is clunky though, let's see if we can get rid of it

eft2 :: (Ord a, Enum a) => a -> a -> [a]
eft2 x y = go x y []
  where 
    go a b c
      | a > b = c
      | a == b = c ++ a:[]
      | otherwise = go (succ a) b (c ++ a:[])

-- using string concatenation is just as slow though, let's use recursion

eft3 :: (Ord a, Enum a) => a -> a -> [a]
eft3 x y
  | x > y = []
  | x == y = [x]
  | otherwise = x : eft3 (succ x) y

-- We can get rid of the Ord constraint by leveraging the mapping between
-- an Enum and Int

eft4 :: Enum a => a -> a -> [a]
eft4 x y
  | fromEnum x > fromEnum y = []
  | fromEnum x == fromEnum y = [x]
  | otherwise = x : eft4 (succ x) y
```

## 9.6 Extracting portions of lists

### Exercises: Thy Fearful Symmetry

```haskell
--09/FearfulSymmetry.hs
module FearfulSymmetry where

split :: String -> [String]
split [] = []
split  x = word : split rest
  where 
    word = takeWhile (/= ' ') x
    rest = (drop 1) $ dropWhile (/= ' ') x

splitOn :: Char -> String -> [String]
splitOn _ [] = []
splitOn  c str = part : (splitOn c rest)
  where 
    part = takeWhile (/= c) str
    rest = (drop 1) $ dropWhile (/= c) str

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines x = splitOn '\n' x

shouldEqual = 
  [ "Tyger Tyger, burning bright"
  , "In the forests of the night"
  , "What immortal hand or eye"
  , "Could frame thy fearful symmetry?"
  ]

main :: IO ()
main = print $ "Are they equal? " ++ show (myLines sentences == shouldEqual)
```

## 9.7 List Comprehensions

### Exercises: Comprehend Thy Lists

1. `[4, 16]`
2. `[]`
3. `[]`, unless `mySqr` is from `[1..10]`

### Exercises: Square Cube

```haskell
--09/SquareCube.hs
module SquareCube where

mySqr = [x^2 | x <- [1..5]]
myCube = [x^3 | x <- [1..5]]

exercise1 = [(x, y) | x <- mySqr, y <- myCube]
exercise2 = [(x, y) | x <- mySqr, y <- myCube, x < 50, y < 50]
exercise3 = length exercise2
```

## 9.8 Spines and nonstrict evaluation

### Exercises: Bottom Madness

1. no
2. yes
3. no
4. yes
5. no
6. yes
7. no
8. yes
9.  yes
10. no

### Intermission: Is it in normal form?

1. WHNF & NF
2. WHNF
3. neither
4. neither
5. neither
6. neither
7. WHNF

## 9.9 Transforming lists

### Exercises: More Bottoms

1. bottom
2. yes
3. bottom
4. Is this character a vowel?
  `itIsMystery :: Char -> Bool`
5.  a. the first 10 square numbers
    b. `[1, 10, 20]` 
    c. `[15, 15, 15]`

6.  ```haskell
    --09/foldbool.hs
    foldBool = map (\x -> (Data.Bool.bool x (-x) (x == 3)))
    ```

## 9.10 Filtering lists of values

### Exercises: Filtering 

```haskell
-- 09/Filtering.hs
module Filtering where

filterThreeMult :: [Integer] -> [Integer]
filterThreeMult = filter (\x -> x `mod` 3 /= 0)

howManyThreeMults :: [Integer] -> Int
howManyThreeMults x = length x - (length . filterThreeMult) x

howManyThreeMults' :: [Integer] -> Int
howManyThreeMults' = length . filter (\x -> x `mod` 3 == 0)

removeArticle :: String -> [String]
removeArticle = filter (not . isArticle) . words  
  where isArticle x = elem x ["a", "an", "the"] 
```

### Zipping exercises

```haskell
-- 09/ZippingExercises.hs
module ZippingExercises where

myZip :: [a] -> [b] -> [(a, b)]
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys
myZip _ _ = []

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f (x:xs) (y:ys) = (f x y) : (myZipWith f xs ys)
myZipWith _ _ _ = []
```

## 9.12 Chapter Exercises

### Data.Char

```haskell
--09/CharExercises.hs
module CharExercises where

import Data.Char

--1
-- isUpper :: Char -> Bool
-- toUpper :: Char -> Char

-- 2 
filterUpper = filter isUpper

-- 3 
capFirst :: String -> String
capFirst (x:xs) = (toUpper x):xs
capFirst _ = "" 

-- 4
strToUpper :: String -> String
strToUpper (x:xs) = (toUpper x):(strToUpper xs)
strToUpper _ = "" 

-- 5 
headToUpper :: String -> Char
headToUpper = toUpper . head

-- 6, wrote it pointfree the first time...
```

### Ciphers

```haskell
--09/Cipher.hs
module Cipher where

import Data.Char

caesar :: Int -> String -> String
caesar key string = go key $ (map toLower . filter isAlpha) string
  where go _ "" = ""
        go n (c:cs) = chr ((ord c + n - ord 'a') `mod` 26 + ord 'a') : go n cs

unCaesar :: Int -> String -> String
unCaesar key string = caesar (negate key) string 

test :: Int -> String -> Bool
test n s = (map toLower . filter isAlpha) s == (unCaesar n . caesar n) s 
```

### Writing your own standard functions

```haskell
--09/StdFunc.hs
module StdFunc where

-- 1
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = if x == True then True else myOr xs

-- 2
myAny :: (a -> Bool) -> [a] -> Bool
myAny f xs = (myOr . map f) xs

-- 3
myElem :: Eq a => a -> [a] -> Bool
myElem x xs = myAny ((==) x) xs

-- 4
myReverse :: [a] -> [a]
myReverse xs = go xs []
  where go [] n = n
        go (n:ns) a = go ns (n:a)

-- 5
squish :: [[a]] -> [a]
squish [] = []
squish ((n:[]):nss) = n : squish (nss)
squish ((n:ns):nss) = n : squish (ns:nss)

-- 6 
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f xs = go f xs []
  where go _ [] [] = []
        go f (x:xs) [] = go f xs (f x)
        go f xs (a:as) = a : (go f xs as)

-- 7
squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

-- 8 
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy cmp (x:xs) = go cmp xs x
  where go _ [] a = a
        go cmp (x:xs) a = go cmp xs (if (cmp x a) == GT then x else a)

-- 9
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy cmp (x:xs) = go cmp xs x
  where go _ [] a = a
        go cmp (x:xs) a = go cmp xs (if (cmp x a) == LT then x else a)


myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
```

## 9.14 Follow-up resources

1. [Data.List documentation for the base library.](http://hackage.haskell.org/package/base/docs/Data-List.html)

2. [Ninety-nine Haskell problems.](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems)

# 10 Folding lists

Okay, so here's the thing about the term "catamorphism":

"Kata" in Greek means "down". The opposite of "kata" is "ana" which means "up".

So we have "catamorphisms" and "anamorphisms". Remember that "morph" means
"form", so a "catamorphism" is a "down-form thing" and an "anamorphism"
is an "up-form thing".

But what the heck do "up" and "down" have to do with "forms". There's a
metaphor that recurs (heh) again and again in functional programming between
height and complexity: Things that have more structure or are more complex are
upwards and things that are simpler are downwards.

So an `Integer` is pretty simple, and is downwards of `[Integer]` or `Maybe
Integer` or `Map String Integer`. 

Functions that go "upwards" in this complexity-space, like from `Integer ->
[Integer]` are, roughly speaking, anamorphisms. Functions that go "downwards"
are catamorphisms.


## 10.4 Fold right

### Exercises: Understanding folds

```haskell
module Folds where

-- 1: 
one = (==) (foldr (*) 1 [1..5]) (foldl (*) 1 [1..5])

-- 2
two = scanl (flip (*)) 1 [1..3]

--3: c

--4: reduce structure

--5
fiveA = foldr (++) "" ["woot", "WOOT", "woot"]
fiveB = foldr max 'a' "fear is the little death"
fiveC = foldr (&&) True [False, True]
fiveD = foldr (||) True [False, True]
fiveE = foldr ((++) . show) "" [1..5]
fiveF = foldl const 'a'  [1..5]
fiveG = foldl const 0 "tacos"
fiveH = foldr (flip const) 0 "burritos"
fiveI = foldr (flip const) 'z' [1..5]
```

### Exercises: Database Processing

```haskell
module DatabaseProcessing where

import Data.Time

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate   UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase = 
  [ DbDate (UTCTime
            (fromGregorian 1911 5 1)
            (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbString "Hello, World!"
  , DbDate (UTCTime
            (fromGregorian 1921 5 1)
            (secondsToDiffTime 34123))
  ]

-- 1 
filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = map unpack . filter isADbDate where
  isADbDate (DbDate _) = True
  isADbDate _ = False
  unpack (DbDate utc) = utc

filterDbDate2 :: [DatabaseItem] -> [UTCTime]
filterDbDate2 = foldr unpackDate [] where
  unpackDate (DbDate utc) acc = utc : acc
  unpackDate _ acc = acc

-- 2
filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = foldr unpackNum [] where
  unpackNum (DbNumber num) acc = num : acc
  unpackNum _ acc = acc

-- 3 
mostRecent :: [DatabaseItem] -> UTCTime
mostRecent db = foldr compareDate base db where
  compareDate (DbDate utc) acc = max utc acc  
  compareDate _ acc = acc
  base = (filterDbDate2 db) !! 0

-- 4 
sumDb :: [DatabaseItem] -> Integer
sumDb = foldr addNum 0 where
  addNum (DbNumber int) acc = int + acc
  addNum _ acc = acc

-- 5
avgDb :: [DatabaseItem] -> Double 
avgDb db = (fromIntegral $ fst tup) / (fromIntegral $ snd tup) where
  tup = foldr addNum (0,0) db
  addNum (DbNumber int) (num,den) = (int + num, den + 1)
  addNum _ acc = acc

avgDb2 :: [DatabaseItem] -> Double
avgDb2 db = n / d where
  n = (fromIntegral $ sumDb db) 
  d = (fromIntegral $ length $ filterDbNumber db)
```

## 10.9 Scans

### Scans Exercises

```haskell
module Scans where

fibs = 1 : scanl (+) 1 fibs
fibsN x = fibs !! x

--1
fibsToN n = take n $ fibs

--2
fibsLessThan n = takeWhile (< n) fibs

--3
factorials = 1 : scanl ratio 1 factorials
  where ratio m n = (m `div` n + 1) * m

factorials2 = scanl (*) 1 [1..]
lazyCaterers = scanl (+) 1 [1..]
```
## 10.10 Chapter Exercises

### Warm-up and reveiw

```haskell
--10/WarmUp.hs
module WarmUp where

-- 1
stops = "pbtdkg"
vowels = "aeiou"

-- 1a
stopVowelStop = [(a, b, c) | a <- stops, b <- vowels, c <- stops]

-- 1b
pVowelStop = [('p', b, c) | b <- vowels, c <- stops]

-- 1c
nouns = ["cat", "dog", "ball", "box"]
verbs = ["throws", "catches", "jumps", "fetches"]

nounVerbNoun =   [(a, b, c) | a <- nouns, b <- verbs, c <- nouns]

-- 2
seekritFunc x = div (sum (map length (words x))) (length (words x))

-- function is average word length
avgWordLength :: String -> Int
avgWordLength x = div totalWordLengths numberOfWords 
  where
    wordList = words x
    numberOfWords = length wordList 
    wordLengths = map length wordList
    totalWordLengths = sum wordLengths

-- 3
preciseAvgWordLength :: String -> Double
preciseAvgWordLength x = totalWordLength / numberOfWords
  where 
    totalWordLength = fromIntegral $ sum $ map length $ words x
    numberOfWords   = fromIntegral $ length $ words x

```

### Rewriting functions using folds

```haskell
--10/FunctionsUsingFolds.hs
module FunctionsUsingFolds where

myAnd :: [Bool] -> Bool
myAnd = foldr (&&) True

-- 1 
myOr :: [Bool] -> Bool
myOr = foldr (||) False

-- 2
myAny :: (a -> Bool) -> [a] -> Bool
myAny f x = foldl check False x where
  check x y = x || f y 

-- 3 

myElem :: Eq a => a -> [a] -> Bool
myElem x xs = myAny ((==) x) xs

-- 4
myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

-- 5
myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldr ((:) . f) [] xs

-- 6 
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs =  foldr g [] xs where
  g x y = if (f x) then (x : y) else y

-- 7 
squish :: [[a]] -> [a] 
squish = foldr (++) []

-- 8
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f = foldr ((++) . f) []

-- 9
squishAgain :: [[a]] -> [a]
squishAgain = squishMap id 

-- 10
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy ord xs = foldr1 g xs
  where g x y = if (ord x y) == GT then x else y

-- 11
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy ord xs = foldr1 g xs
  where g x y = if (ord x y) == LT then x else y
```

## 10.12 Follow-up resources

1. [Haskell Wiki. Fold.](https://wiki.haskell.org/Fold)

2. [Richard Bird. Sections 4.5 and 4.6 of Introduction to Functional](Programming using Haskell (1998).)

3. Antoni Diller. Introduction to Haskell.

4. [Graham Hutton. A tutorial on the universality and expressive-
ness of fold.](http://www.cs.nott.ac.uk/~gmh/fold.pdf)

# 11 Algebraic Datatypes

## 11.5 Data constructors and values

### Exercises: Dog Types

1. type constructor
2. `* -> *`
3. `*`
4. `Num a => Doggies a`
5. `Doggies Integer`
6. `Doggies String`
7. `data constructor (both?)`
8. `a -> DogueDeBordeaux a`
9. `DogueDeBordeaux String`

## 11.6 What's a type and what's data?

### Exercises: Vehicles

```haskell
--11/Vehicles.hs
module Vehicles where

data Price = Price Integer deriving (Eq, Show)
data Manufacturer = Mini | Mazda | Tata deriving (Eq, Show)
data Size = Small | Medium | Large deriving (Eq, Show)
data Airline = PapuAir 
             | CatapultsR'Us 
             | TakeYourChancesUnited 
             deriving (Eq, Show)

data Vehicle = Car Manufacturer Price 
             | Plane Airline Size
             deriving (Eq, Show)

myCar = Car Mini (Price 14000)
urCar = Car Mazda (Price 20000)
clownCar = Car Tata (Price 7000)
doge = Plane PapuAir Small

-- 1. Vehicle

-- 2
isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

isPlane :: Vehicle -> Bool
isPlane (Plane _ _) = True
isPlane _ = False

areCars :: [Vehicle] -> Bool
areCars = any isCar 

-- 3

getManu :: Vehicle -> Manufacturer
getManu (Car manu _) = manu

-- 4: non-exhaustive patterns

-- 5 see above
```


## 11.8 What makes these datatypes algebraic?

### Exercises: Cardinality

1. cardinality is 1
2. `3`
3. `2^16 = 65536`
4. `2^64`
5. `Int8` is an 8 bit integer. `2^8` is 256. 

### Exercises: For Example

1. `MakeExample`'s type is `Example`, `Example` does not have a type, it is a type
2. `Example` has data constructor `MakeExample` with an instance of typeclass `Show`
3. `MakeExample` is a function from `Int` to `Example`

## 11.9 newtype

### Exercises: Logic Goats

```haskell
{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances #-}

--10/LogicGoats.hs
module LogicGoats where

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

instance TooMany (Int, String) where
  tooMany (n, str) = n > 42 || (length str) > 42

-- instance TooMany (Int, Int) where
-- tooMany (n, m) = n + m > 42

instance (Num a, TooMany a) => TooMany (a, a) where
  tooMany (n, m) = tooMany (n + m)

newtype Goats = Goats Int deriving (Eq, Show, TooMany)
```

## 11.10 Sum types

### Exercises: Pity the Bool

1. 4, `Bool` has cardinality 2 and there are 2 `Bools` in the sum type,
   so `2 + 2 = 4`
2. 258, the type can either be `BoolyBool True`, `BoolyBool False` or a `Numba`. 
   If you go over the Int8 bounds, you get a compiler warning `-Woverflowedliterals`


## 11.12 Normal Form

## Exercises: How Does Your Garden Grow?

1.  ```
    data Garden = Gardenia String 
                | Daisy String 
                | Rose String
                | Lilac String
                deriving Show
    ```

## 11.13 Constructing and deconstructing values

### Exercises: Programmers

```haskell
--11/Programmers.hs
module Programmers where

data OperatingSystem = GnuPlusLinux | OpenBSDPlus | Mac | Windows  
                        deriving (Eq, Show)
data ProgrammingLanguage = Haskell | Agda | Idris | PureScript
                           deriving (Eq, Show)

data Programmer = Programmer { os   :: OperatingSystem
                             , lang :: ProgrammingLanguage }
                  deriving (Eq, Show)

-- exercise

allOperatingSystems :: [OperatingSystem]
allOperatingSystems = [ GnuPlusLinux
                      , OpenBSDPlus
                      , Mac
                      , Windows
                      ]

allLanguages :: [ProgrammingLanguage]
allLanguages = [Haskell, Agda, Idris, PureScript]

allProgrammers :: [Programmer]
allProgrammers = [(Programmer os lang) | os   <- allOperatingSystems
                                       , lang <- allLanguages ]
```

## 11.14 Function type is exponential

Here's how I visualize why the function type is exponential:

The set theory defintion is, roughly, that a function is a set of
pairs of elements some input set `A` and elements of some ouput set `B`,
such that there for each element `a` in `A`, there is one and only one pair
`(a, _)` in `f` (assuming the function is total).

Suppose we're considering functions from `Bool` to `Bool`. As haskell code:

```haskell
f1 :: Bool -> Bool
f1 True = True
f1 False = True
```

But written as a set, `f1` looks like:

```
{ {T, T},  {F, T} }
```

Another function `f2` might be:

```haskell
f2 :: Bool -> Bool
f2 True = True
f2 False = False
```

```
{ {T, T},  {F, F} }
```

So now let's ask ourselves: How many distinct functions from `Bool` to `Bool`
are there?

Well, `Bool` is small so we can just list them out:


```
{ {T, T},  {F, T} }
{ {T, T},  {F, F} }
{ {T, F},  {F, T} }
{ {T, F},  {F, F} }
```

So there are four, which from the book makes sense because `Bool` has a
cardinality of 2 and function types as exponentials implies that 
the cardinality of `Bool -> Bool` is `2^2 = 4`.

But, why is this the case? Here's something interesting, in the listing 
of possible functions as sets:

```
{ {T, T},  {F, T} }
{ {T, T},  {F, F} }
{ {T, F},  {F, T} }
{ {T, F},  {F, F} }
```

We're actually repeating a lot of information in each line. See how all
the `T`'s and `F`'s line up? We already know that in each function from
`Bool` there's going to be a pair with `True` and a pair with `False` in
the first position. What makes the function unique is really the outputs,
not the inputs.

Let's rewrite the function listing, by picking an order for elements
of `Bool`: True, False.

Then we can rewrite:
```
{ {T, T},  {F, T} } = TT 
{ {T, T},  {F, F} } = TF
{ {T, F},  {F, T} } = FT
{ {T, F},  {F, F} } = FF
```

As long as we know the ordering `True, False`, we can figure out that the first
symbol in the pair `TF`, for example, refers to to the output from `True` and
the second symbol refers to the output from `False`.

In other words, when we look at a function, we can look up the function's
output for a given input by looking at what symbol appears the input's position
in the ordering. 

For example, what does the function `FT` return for the 
input `True`? `FT` has an `F` for `False` in the `True` position, so it
returns `False`. 

The function `FT` and `FF` are the same in the `True` position,
and differ in the `False position.

This may remind you of how digits work in numbers, except instead of
the ones position, tens postion etc, the places represent inputs. 

Watch what happens if we map the symbol `T` to `1` and the symbol `F` to `0`:

```
TT = 11
TF = 10
FT = 01
FF = 00
```

These are all the 2 digit binary numbers. There are four of them,
because each digit can be either `1` or `0`, and there are two digits,
so `2 symbols ^ 2 digits = 4`

If there were three digits, there would be `2^3 = 8` possibile numbers.
If there were three digits in base ten there would be `10^3 = 1000` possible numbers.

The elements of a function's input set can be mapped to 
"digit" positions, and the elements of the output set can be mapped to "digit"
symbols. Then you can write down a unique representation of the function
by writing the ouput symbols in the input positions. Because the number of
possible unique representations is the same as the number of possible functions,
and because the number of representations is the number of base symbols raised
to the number of digits (base ^ digitnumber = uniques), the number of possible
unique functions from one set to another is the number elements in the output
set raised to the number of element in the input set. 

## Exercises: The Quad

1. 8
2. 16
3. 4^4 = 256
4. 2*2*2 = 8
5. 2^2^2 = 16
6. (4^4)^2 = 65536

## 11.17 Binary Tree

### BinaryTree

```haskell
--11/BinaryTree.hs
module BinaryTree where

data BinaryTree a = Leaf | Node (BinaryTree a) a (BinaryTree a)
                    deriving (Eq, Show, Ord)
-- insert
insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
  | b == a = Node left a right
  | b < a  = Node (insert' b left) a right
  | b > a  = Node left a (insert' b right)

-- map
mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) = (Node (mapTree f left) (f a) (mapTree f right))

testTree' :: BinaryTree Integer
testTree' = Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 Leaf)

mapExpected = Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 Leaf)

mapOkay = mapTree (+1) testTree' == mapExpected

-- list
preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node left a right) = [a] ++ (preorder left) ++ (preorder right)

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left a right) = (inorder left) ++ [a] ++  (inorder right)

postorder :: BinaryTree a -> [a]
postorder Leaf = []
postorder (Node left a right) = (postorder left) ++ (postorder right) ++ [a]

testTree :: BinaryTree Integer
testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

testPreorder = preorder testTree == [2, 1, 3]

testInorder = inorder testTree == [1, 2, 3]

testPostorder = postorder testTree == [1, 3, 2]

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree f ac Leaf = ac
foldTree f ac (Node left v right) = foldTree f (foldTree f (f v ac) left) right

foldTree' :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree' f ac bt = foldr f ac (inorder bt)

mapTree' :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree' f bt = foldTree g Leaf bt
  where g v acc = Node acc (f v) Leaf

mapTree2 :: Ord b => (a -> b) -> BinaryTree a -> BinaryTree b
mapTree2 f bt = foldTree g Leaf bt
  where g v acc = insert' (f v) acc

testTree2 = Node (Node (Leaf) 2 (Node Leaf 5 Leaf)) 1
                 (Node (Node Leaf 6 Leaf) 3 (Node Leaf 7 Leaf))

 
foldTree1 :: (a -> b -> b -> b) -> b -> BinaryTree a -> b
foldTree1 f a Leaf = a
foldTree1 f a (Node left v right) = 
  f v (foldTree1 f a left) (foldTree1 f a right)

mapTree1 :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree1 f bt = foldTree1 g Leaf bt where
  g a left right = Node left (f a) right
```


## 11.18 Chapter Exercises

### Multiple Choice

1. a
2. c
3. b
4. c

### Ciphers

```haskell
--11/Vignere.hs
module Vignere where

import Data.Char

vignere :: String -> String -> String
vignere key cleartext = map caeserHelper $ zip key' clr' where
    pre = (map toLower . filter isAlpha)
    clr' = (pre cleartext)
    key' = take (length clr') $ cycle (pre key)
    caeserHelper (a, b) = chr ((ord a + ord b - 2*ord 'a') `mod` 26 + ord 'a')

unVignere :: String -> String -> String
unVignere key ciphertext = map caeserHelper $ zip key' ciphertext where
    pre = (map toLower . filter isAlpha)
    key' = take (length ciphertext) $ cycle (pre key)
    caeserHelper (a, b) = chr ((ord b - ord a) `mod` 26 + ord 'a')
```

### As-patterns 

```haskell
--11/AsPatterns.hs
module AsPatterns where

import Data.Char

doubleUp :: [a] -> [a]
doubleUp [] = []
doubleUp xs@(x:_) = x : xs

-- 1
isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf (x:xs) b = elem x b && isSubsequenceOf xs b

-- 2
capWords :: String -> [(String, String)]
capWords str = map cap $ words str where
  cap a@(x:xs) = (,) a $ (toUpper x):xs
```

### Language exercises

```haskell
--11/LanguageExercises.hs
module LanguageExercises where

import Data.Char

capWord :: String -> String
capWord a@(x:xs) = if x >= 'a' && x <= 'z' 
                          then chr((ord x) - 32):xs 
                          else a

capParagraph :: String -> String
capParagraph p = init $ concat $ map (++ " ") $ capp $ words p where
  capp  [] = []
  capp  (x:xs) = if (last x) == '.' then x:(capp' xs) else x:(capp xs)
  capp' [] = []
  capp' (x:xs) = if (last x) == '.' then (capWord x):(capp' xs) else x:(capp xs)
``` 

### Phone exercise


```haskell
--11/Phone.hs
module Phone where

import Data.List
import Data.Char

data Phone = Phone {buttons :: [Button]} deriving (Eq, Show)

data Mode = Shift | None deriving (Eq, Show)
data Button = Button {key :: Key, output :: String} deriving (Eq, Show)
type Key = Char 
type Press = Int

daPhone :: Phone
daPhone = Phone 
          [ Button '1' "1"    , Button '2' "ABC2", Button '3' "DEF3"
          , Button '4' "GHI4" , Button '5' "JKL5", Button '6' "MNO6"
          , Button '7' "PQRS7", Button '8' "TUV8", Button '9' "WXYZ9"
          , Button '*' "^*"   , Button '0' " 0"  , Button '#' ".,#"
          ]

convo = ["Wanna play 20 questions", 
         "Ya",
         "U 1st haha",
         "Lol ok. Have u ever tated alcohol lol",
         "Lol ya",  
         "Wow ur cool haha. Ur turn",
         "Ok. Do u think I am pretty lol",
         "lol ya",
         "Haha thanks just makin sure rofl ur turn"]

keyMap :: Phone -> (Key, Press) -> Mode -> Char
keyMap phone (k, p) mode = 
  if mode == Shift then out else toLower out where
    out = outCycle !! ((p - 1) `mod` (length outCycle))
    outCycle = unpack $ lookup k $ zip (map key pb) (map output pb)
    pb = (buttons phone)
    unpack (Just a) = a

textOut :: Phone -> [(Key, Press)] -> String
textOut phone kps = go phone kps None where
  go phone [] _ = [] 
  go phone (('*', 1):kps) None = go phone kps Shift
  go phone (('*', 1):kps) Shift = go phone kps None
  go phone (kp:kps) m =  ((keyMap phone) (shift kp) m) : go phone kps None
  shift (k, p) = if k == '*' then (k, p - 1) else (k, p)

invButton :: Button -> [(Char, (Key, Press))]
invButton b = go ((key b), (output b)) 1 where
  go (k, []) _ = []
  go (k, (c:cs)) n = (c, (k, n)) : go (k, cs) (n + 1)

invKeyMap :: Phone -> Char -> Maybe (Key, Press)
invKeyMap phone c = lookup c $ concatMap invButton $ buttons daPhone

keyPressIn :: Phone -> String -> [Maybe (Key, Press)]
keyPressIn phone [] = [] 
keyPressIn phone (x:xs) = if isUpper x then up else lo where
  up = (Just ('*', 1)):(invKeyMap phone x):(keyPressIn phone xs)
  lo = (invKeyMap phone (toUpper x)):(keyPressIn phone xs)

fingerTaps :: [Maybe (Key, Press)] -> Press
fingerTaps a = go a 0 where
  go [] n = n
  go ((Nothing):xs) n = go xs n
  go ((Just (k, p)):xs) n = go xs (p + n)

mostPopularLetter :: String -> Char
mostPopularLetter str = head $ maximumBy cmp $ group str where
  cmp a b = compare (length a) (length b)

costOfMostPopularLetter :: Phone -> String -> Press
costOfMostPopularLetter phone str = fingerTaps $ keyPressIn phone [a] where
  a = mostPopularLetter str

coolestLtr :: [String] -> Char
coolestLtr msgs = mostPopularLetter $ map mostPopularLetter msgs

coolestWord :: [String] -> String
coolestWord msgs = head $ maximumBy cmp $ group $ concatMap words msgs where 
  cmp a b = compare (length a) (length b)
```

[TODO: I'm looking back on this code several months after writing it. It's
awkward, but I'll leave it as is for now, since it's an okay example
of solving the problem with only the tools covered in the book thus far. I
think I should do an example of how this project gets a lot easier when you can
use things like the State monad.]

### Hutton's Razor

```haskell
--11/Hutton.hs
module Hutton where

--1
data Expr = Lit Integer | Add Expr Expr

eval :: Expr -> Integer
eval (Lit n) = n
eval (Add a b) = (+) (eval a) (eval b) 

-- 2

printExpr :: Expr -> String
printExpr (Lit n) = show n
printExpr (Add a b) = (printExpr a) ++ " + " ++ (printExpr b)
```

# 12 Signaling adversity

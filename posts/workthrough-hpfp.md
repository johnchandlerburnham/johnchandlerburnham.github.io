---
title: "Workthrough: Haskell Programming From First Principles (Allen & Moronuki)"
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

# Chapter 1: All You Need is Lambda

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

# Chapter 2: Hello Haskell!

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

There are a lot of different ways to fit pieces together.  Two standard two by
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

1. c.
2. b.
3. a
4. d

## 5 Types

I want to acknowledge how apt and lovely the quote at the beginning of this
chapter is. It is an excerpt from the Wallace Stevens poem: [The Idea of Order
at Key West](https://www.poetryfoundation.org/poems/43431/the-idea-of-order-at-key-west)



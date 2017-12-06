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

# Introduction

# Chapter 1: All You Need is Lambda

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

**beta normal form**: When an expression cannot be further reduced through
*beta reduction* (i.e. application of abstractions). This signals the end
of the evaluation.

**combinator**: A lambda term with no free variables. $\lambda x.x$ is a combinator,
$\lambda x.xy$ is not.

**divergence**: If an expression can never reach *beta normal form*, it 
is said to diverge. For example, $(\lambda x.xx)(\lambda x.xx)$ diverges.
This corresponds to non-terminating function (an infinite loop).

## Intermission: Equivalence Exercises (p.13)

1. `\xy.xz` is equivalent to `\mn.mz`, by alpha equivalence of `x` with `m`
and `y` with `n`.
2. `\xy.xxy` is equivalent to `\a.(\b.aab)`, by currying and alpha equivalence.
3. `\xyz.zx` is equivalent to `\tos.st`.

## Chapter Exercises (p.17)

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

## Follow-up Resources

1. [Raul Rojas. A Tutorial Introduction to the Lambda 
    Calculus](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)

2. [Henk Barendregt; Erik Barendsen. Introduction to Lambda
   Calculus](http://www.cse.chalmers.se/research/group/logic/TypesSS05/
   Extra/geuvers.pdf)

3. [Jean-Yves Girard; P. Taylor; Yves Lafon. 
   Proofs and Types](http://www.paultaylor.eu/stable/prot.pdf)


# Chapter 2: Hello Haskell!

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



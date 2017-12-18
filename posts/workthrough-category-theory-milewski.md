---
title: "Workthrough: Haskell Programming (Milewski)"
author: jcb
date: 2017-12-15
tags: workthrough, haskell, math, category-theory
---

**Work in Progress**



# 1 Category: The Essence of Composition

**category**: A structure consisting of objects and arrows between objects,
such that arrows compose. That is, if a category has objects `A`, `B` and `C`
along with arrows `A -> B` and `B -> C`, then it also has the arrow `A -> C`.


## 1.1 Arrows as Fucntions.

Arrows are also called morphisms, which comes from the Greek "morphe" meaning
form.

Notation:
- `.` is composition, `(g . f)(x) = g(f(x))`
- `::` is type of, like `f :: Integer` 
- `->` is an arrow, `f :: A -> B` means `f` is a morphism from `A` to `B`


## 1.2 Properties of Composition

1. Composition of arrows is associative, so that
  
    ```
    h . (g . f) = (h . g) . f = h . g . f
    ```

    This makes sense with the definition of a category. Suppose a category contains
    objects `A, B, C, D` and arrows:

    ```
    f :: A -> B
    g :: B -> C
    h :: C -> D
    ```

    Then by definition it contains:

    ```
    (f . g) :: A -> C
    (h . g) :: B -> D
    (h . g . f) :: A -> D
    ```

    Associativity just means that it doesn't matter what order we compose arrows:

    ```
    h . (g . f) == (h . g) . f == h . g . f
    ```


2.  There is an identity arrow `A -> A` for every object `A`. Such that for
    arrows `f :: A -> B` and `g :: B -> A`:

    ```
    f . id_a = f
    id_a . g = g
    ```


One thing that confuses me is that it seems like this implies that in some
case that there can't be multiple arrows from one object to another. 

Suppose a category `Cat` has objects `A`, `B` and arrows

```
f' :: A -> B
f  :: A -> B
g  :: B -> A
id_a :: A -> A
id_b :: B -> B
```

If `Cat` is a category, then the compositions of `g . f` and `g . f'` must
be arrows in the category:

```
g . f :: A -> A 
g . f' :: A -> A 
```

But the only arrow of type `A -> A` is `id_a`, so

```
g . f = g . f' = id_a
```

And equivalently:

```
f . g= f' . g = id_b
```

Which implies:


```
f' = f' . id_a = f' . g . f = id_b . f = f 
```

So, either `Cat` is not a category, or `f' == f.`

cf. [Haskell Wikibook page on Category Theory](https://en.wikibooks.org/wiki/Haskell/Category_theory#Hask,_the_Haskell_category)

I think the important thing to keep in mind here is that when looking
at a possible structure to see if its a category, the structure is constant. There
aren't any implicit elements of `Cat` that could also satisfy the property
that e.g `(g . f)` is in `Cat`. We actually have to look in `Cat` to find if
something fits the properties. If not, it's not a category. 

When I first approached this topic I confused the statements:

- For any arrows `g` and `f` in a category `C`, their composition `(g . f)` must
also be an arrow in `C`. (**Right**) 
- If arrows `g` and `f` are arrows in `C`, add a new arrow `(g . f)` to `C`. (**Wrong**)

This really confused me for a bit, until I realized that when I was doing the
latter I was just trying to build a superset of `C` that actually was a
category.

## 1. 4 Challenges

1. `I = (\x. x)` in the lambda calculus.
2. `compose = (\x y z. x (y z))`

3.  `compose I F X = (\x y z. x (y z)) I F X = I (F X) = F X`
    `compose F I X = (\x y z. x (y z)) F I X = F (I X) = F X`

4. No, links are not composable.
5. Friendships are not composable.
6. When the edges are composable, and every node has a self-directed edge.

----

# 2 Types and Functions

## 2.3 What are Types

**Set**: A category whose objects are sets and whose arrows are functions.
**Hask**: Set, except every set is extedned with the bottom element `_|_`,
indicating non termination.

The question of whether **Hask** is actually a category appears to be
an [interesting one](http://math.andrej.com/2016/08/06/hask-is-not-a-category/comment-page-1/)

[TODO: Workthrough of https://www.cs.ox.ac.uk/jeremy.gibbons/publications/fast+loose.pdf]

## 2.4 Why Do we need a Mathematical Model

**operational semantics**: Describing how a program runs by trying to 
directly reason about how it operates on some idealized abstract machine.

**denotational semantics**: Describing how a program runs by building a 
mathematical structure that corresponds to the program and proving theorems
about that structure.

## 2.5 Pure and Dirty Functions

**pure function**: A function that returns the same output for the same
input, and whose output and input are explicit. 

I wonder if a function in, for example, `C` could be considered pure, but only
if we treat the whole state of the machine, or maybe the whole state of the
universe as the input and output types. 


## 2.6 Examples of Types 

**Void**: The type with no elements (other than `_|_`, of course)

**()**: Unit, the type with only one element: `()`


## 2.6 Challenges

1. 2. 3. 4. 

[TODO: Memoization in Haskell.]


5. 4 functions
```
not :: Bool -> Bool
id_bool :: Bool -> Bool
(const True) :: Bool -> Bool
(const False) :: Bool -> Bool
```



6.  ```
    absurdUnit :: Void -> ()
    absurdTrue :: Void -> Bool
    absurdFalse :: Void -> Bool

    id_Void :: Void -> Void
    id_unit :: () -> ()
    id_bool :: Bool -> Bool

    not :: Bool -> Bool
    (const True) :: Bool -> Bool
    (const False) :: Bool -> Bool

    (const True)  :: () -> Bool
    (const False) :: () -> Bool

    unit :: Bool -> ()
    ```

[TODO: Diagram]


# 3 Categories Great and Small

## 3.1 No objects

The empty category!

## 3.2 Simple Graphs

**free category**: A category generated by a directed graph by turning
nodes into objects, edges into arrows and adding new edges for every composition
of arrows.

Okay so generating free categories is what I was doing in chapter 2 that
was confusing me. Subtle! 

## 3.3 Orders

**preorder**: If a set `P` has a binary relation `pre :: P -> P -> Bool` such
that for all `x :: P, y :: P, z :: P` 

```
pre x x = True                      -- reflexive
pre x y && pre y z => pre x z       -- transitive
```

Then `pre` is a preorder.

**partial order**: If a set `P` has a binary relation `part :: P -> P -> Bool`
such that for all `x :: P, y :: P`:

```
part x y = pre x y                 -- part is a preorder
part x y && part y x => x == y     -- antisymmetric 
```

then `part` is a partial order

**total order**: If a set `P` has a binary relation `tot :: P -> P -> Bool`,
such that for all `x :: P, y :: P`:

```
tot x y = part x y                 -- tot is a partial order
tot x y || tot y x = True          -- total (defined for all P)
```

then `tot` is a total order.`

**thin category**: A category where between any two objects `X` and `Y`
there is at most one arrow `X -> Y` from `X` to `Y`.

**hom-set**: The set of arrows from an object `X` to an object `Y`.
`hom-set :: Category -> Object -> Object -> {Arrow}`. I don't really
like the name "hom-set". I get that "hom" stands for "homomorphism", but I hate
using apocope (eliding syllables from the ends of words) to generate new terms.
It's slangy, offloads important "info" onto implicit context, sounds ugly
and confuses me. Hate it.

I've read that some books use "morphisms" as a way to describe "hom-set".
That's a lot better, but still not perfect...

I kind of like thinking about the set of morphisms from `X` to `Y` as the
"volley" of arrows from `X` to `Y`. I especially like that "volley" comes
from Latin "volare: to fly". And that's really what we're after, which
arrows "fly" from `X` to `Y`:

```
volley :: Category -> Object -> Object -> {Arrow}
```

We'll also need term for all the arrow in a whole category, not just between
two ojects:

```
vol :: Category -> {Arrow}
```

Okay, it's another apocope, but this is actually a meaningful one. "Vol"
is a French word meaning "flight". And we can think of all the a
all the arrows in a category as being like a "flock" or a "flight" of
arrows.

I've also read that the vol (hom-set) of a category is not necessarily
a set. So I think the term "hom-set" really fails utterly in all parts for
clearly conveying the concept. 

I'm going to use my own made-up "vol", "volley" terminology, mostly because
I think it's pretty. I'll try to include definitions whenever I stray
to far from this context:

```
volley C a b = hom-set_C(a, b)
vol C = all morphisms of C
```

[TODO: Extend archery terminology to other category theory concepts] 


## 3.4 Monoid as Set

**monoid** A set `M` with a binary operation `mappend :: M -> M -> M` and an
element `mempty :: M` such that for any `a :: M, b :: M, c :: M`:

```
mappend (mappend a b) c = mappend a (mappend b c)  -- associative
mappend mempty a = mappend a mempty = a            -- identity element
```

Addition of integers is a monoid:

```
(a + b) + c = a + (b + c)
0 + a = a + 0 = a
```

So is multiplication of integers:

```
(a * b) * c = a * (b * c)
1 * a = a * 1 = a
```

## 3.5 Monoid as Category

Treat `M` as an object, rather than a set. We can convert all elements
of `M` into arrows:

The identity element turns into the identity arrow:

```
mappend a mempty = mappend mempty a = id_M a = a id_M = a  -- identity arrow
```

And every element `x` of `M` turns into:

```
mappend x :: M -> M
```

where composition of arrows becomes:

```
(mappend x1) . (mappend x2) = (mappend (mappend x1 x2)) :: M -> M
```

E.g, if the monoid is addition of integers:

```
(+ 2) . (+ 3) = (+ (2 + 3)) = (+ 5)
```

And since `mappend` is associative, so is composition

```
(mappend x1) . (mappend x2) . (mappend x3) 
= ((mappend x1) . (mappend x2)) . (mappend x3)
= (mappend (mappend x1 x2)) . (mappend x3)  
= mappend (mappend (mappend x1 x2) x3)
= mappend (mappend x1 (mappend x2 x3))     
= (mappend x1) . (mappend (mappend x2 x3))
= (mappend x1) . ((mappend x2) . (mappend x3))
```

E.g. with the integer addition monoid:
```
(+2) . (+3) . (+4) = ((+5) . (+4)) = (+9)
                   = ((+2) . (+7)) = (+9)
```

And thus we've turned `M` into a category!

And we can just as easily turn `M` back into a set by 
taking the set of arrow with `vol :: Category -> {Arrow}`, (hom-set).

## 3.6  Challenges

1.  a. Graph `G` with node `A` and no edges. Adding

    ```
    id_a :: A -> A
    ```

    Gives a category. 

    b. This is a category
    c.  Graph `G` with nodes `A`, `B` and edge `A -> B`. Adding

    ```
    id_A :: A -> A
    id_B :: B -> B
    ```

    Gives a category.

    d. Let the single node be the object `String`. 
       from each edge generate prepender and appender arrows for each letter,
       so the `'a'` edge becomes `(++ "a")` and `("a" ++)`.
       Then add an empty string (++ "") arrow, which is the identity.
       Then add arrows for the compositions of all arrows. And now we 
       have the `String` monoid category.

2.  a.  Inclusion is 

        - reflexive, since by definition all elements of `A` are in `A`
        - transitive, since if `A` is in `B` all elements of `A` are also in `B`
        - antisymmetric, since if `A` is in `B` and `B` is in `A`. there are
          no elements that they do not share, so all their elements are the
          same, and thus `A == B`
        - not necessarily total from the information given. If the set of sets
          is the set of sets of integers, for example, then `{1}, {2}` are
          both in the set, but `{2}` is not in `{1}` and 
          `{1}` is not in `{2}`.
         
          But if the set of sets is, e.g. the set of the empty set `{{}}`, then
          the inclusion relation could be total. So this is actually an
          interesting question: 

          I think we can define this recursively: a set with total order is
          either the empty set or a set of sets with total order:

          ```
          T-Set = {} | Set T
          ```
          
          But then the question is how complicated does this set get? Because
          all the Von Neumann ordinals:

          ```
          0 = {}
          1 = {0} = {{}}
          2 = {1} = {{{}}}
          ...
          ```
          are in `T-set`.

          Oh, actually, this doesn't work, because the inclusion
          relation the question only goes one level deep, I think.
          `A,B,C,D` are not elements of `{{A, B}, {C, D}}`, so `0` is not
          in `2` with Von Neumann encoding.

          But if we changed our inclusion relation to:

          `A` is in `B` if all the elements of `A` are *included* in elements
          of `B`.

          Then I think we get the `T-Set` above for all the sets with total
          order.

          But I'm at the limits of my set theory here. I think
          I'll add a book to my reading list and come back to this.
          
          [TODO. Do a workthrough on set theory]
    
    b.  Skipping. Don't care about `C++`
    
3.  `And-Monoid:
    ```
    mempty = True
    mappend = (&&)

    x && True = x
    True && x = x

    (x && y) && z = z && (y && z)
    ```

   
    `Or-Monoid:`
    ```
    mempty = False
    mappend = (||)

    x || False = x
    False || x = x

    (x || y) || z = z || (y || z)
    ```

4.  Bool Monoid Category, has object bool and arrows:

    ```
    andTrue :: Bool -> Bool   -- identity
    andFalse :: Bool -> Bool  -- always returns false

    andFalse . andFalse = andFalse
    ```

    And is commutative, so thats all there is.

5.  Addition Mod 3, has object Int3 and arrows:

    ```
    (+ 0) :: Int3 -> Int3    -- identity
    (+ 1) :: Int3 -> Int3
    (+ 2) :: Int3 -> Int3

    (+ 1) . (+ 2) = (+ 2) . (+ 1) = (+ 0)
    (+ 1) . (+ 1) = (+ 2)
    (+ 2) . (+ 2) = (+ 1)
    ```
          

# 4 Kleisli Categories

This is a lot of`C++` code that I'm not particularly interested in deciphering.
Since I already have some familiarity with monads I'm gonna skip it
and come back if I'm blocked.


# 5 Products and Coproducts

## 5.1 Initial Object

**initial object**: The initial object is the object that has one and
only one morphism going to any object in the category.

This is like `Void`

## 5.2 Terminal Object

**terminal object**: The terminal object is the object with one and
only one morphism coming to it from any object in the category.

This is like `()`

**poset**: A partially ordered set.

## 5.3 Duality

**opposite category**: For any category `C`, the opposite or dual category
`C^op` is `C` with all the arrows reversed. If `f` and `g` are arrows
in `C`, then `(g . f) = (f^(op) . g^(op)`.

## 5.4 Isomorphisms

**inverse**: If for two objects `A` and `B` there are
two arrows `f :: A -> B` and `g :: A -> B`, such that:

```
f . g = id_A
g . f = id_B
```

`f` and `g` are inverses, or isomorphisms, and `A` and `B` are said
to be isomorphic.


### Theorem: Any category has at most one initial object (up to isomorphism)
Proof:

Suppose a category `C` has two initial objects `I1` and `I2`. Then by
definition it has the identity arrows:

```
id_I1 :: I1 -> I1
id_I2 :: I2 -> I2
```

And because `I1` and `I2` are initial objects, there must be only one
arrow from `I1` to `I2`, and only one arrow from `I2` to `I1`:

```
f :: I1 -> I2
g :: I2 -> I1
```

But if `f` and `g` are arrows in `C` then so are

```
(f . g) :: I2 -> I2
(g . f) :: I1 -> 11
```

And since an initial object has only one arrow to every other object in 
the category, including itself:

```
(f . g) = id_I2 :: I2 -> I2
(g . f) = id_I1 :: I1 -> 11
```

And therefore `f` and `g` are inverses, so `I1` and `I2` are isomorphic.

Furthermore, since `I1` and `I2` are intitial objects, `f` and `g` are
the only arrows between them, and therefore are unique isomorphism.

## 5.5 Products

**product**: A product of two objects `X1` and `X2` in a category `C` is an
object `X` with two arrows `p1 :: X -> X1, p2 :: X -> X2` with the property
that for all objects `Y` in `C` with arrows `f1 :: Y -> X1, f2 :: Y -> X2`,
there is a unique morphism `f :: Y -> X` such that `f . p1 = f1, f . p2 = f2`.

One way to think about this is whenever a product of `X1` and `X2` exists,
all the objects that have arrows to `X1` and `X2` have arrows to the product
object `X`. In other words, `X` is the most "downwind" or terminal-like
object in the collection of objects that have morphisms to `X1` and `X2`


## 5.6 Coproduct

**coproduct**: The dual of the product. Take the definition of the product
and reverse the arrows. In other words, the coproduct `X` of `X1` and `X2`
is the object that has arrows to every object that both `X1` and `X2` have
arrows to. It is the most "upwind", or initial-like object in
the collection of objects that have arrows from both `X1` and `X2`.

## 5.8 Challenges

1. See Theorem in 5.4
2.










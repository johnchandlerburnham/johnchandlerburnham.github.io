---
title: "Notes (TECP 01/13): Boolean Logic"
author: jcb
date: 2018-04-23
tags: notes, programming, hardware
---

# Boolean Logic

Imagine a red ball. A round ruby-colored sphere. Maybe it's a large ball like
a red beach ball. Or maybe it's small like the 3 ball on a pool table.
Regardless of what size it is, it is very important that it be round and that it
be red. You are not imagining a blue ball, or a red cube, or even a green pyramid.
You are imagining a red ball.

Close your eyes and fix the image of the red ball in your mind.

Now answer the following questions:

1. Is the ball you imagined red?
2. Is the red thing you imagined a ball?
3. Is the ball you imagined blue?
4. Is the red thing you imagined a cube?

Now, if you followed the instructions, it should have been easy to answer these
questions. You probably responded with "Yes" to the first two and "No" to
the last two. Let's change the questions into statements about the red ball
you imagined, and this time try to figure out whether the statements are true or false.

1. The ball you imagined was red.
2. The red thing you imagined was a ball.
3. The ball you imagined was blue.
4. The red thing you imagined was a cube.

Some readers may object that words are inherently vague and that
two different people may mean different things by the words "red" and "ball,"
and therefore it's impossible to assign truth-values (Trues and Falses) to the
above sentences in a coherent way. To those people I can only ask to figure out
the truth-value of the sentence "It is impossible to assign coherent truth-values
to sentences." It's an important question, one that has occupied many philosophers
and theologians over the centuries.

In programming, however, a fundamental assumption we make is that it is possible
to answer true and false questions in a meaningful way. In fact in a loose way,
the whole discipline of computing is an elaborated way of trying to figure out
all the things we can meaningfully do with Trues and Falses. Questions like: "Is
the indicator light on?", "Was my friend request accepted?", "Is this number divisible by 2?",  "Does this program halt?" etc. etc.

Let's run with that assumption: A statement in Computing is always either True or False, never both, never neither, never some third thing. This assumption
is the basis of what's called Boolean logic.

Returning to the red ball, can you assign truth-values to the following
compound sentences? Keep in mind that under our assumption everything is either True or False. No "half-trues" allowed. :

1. It is red and it is a ball.
2. It is a ball and it is red.
3. It is a cube and it is red.
5. It is blue and it is a ball.
6. It is red and it is blue.
7. It is red and it is red.

Let's go over these in order:

1. It is red and it is a ball.
2. It is a ball and it is red.

A red ball is both red and a ball, so the compound sentences is True. It
doesn't matter what order the two sub-parts of the sentence occur.

3. It is a cube and it is red.

A red ball is red, but it is not a cube. The first part "it is a cube" is
False, and the second part "it is red" is True. So the sentence is half-True,
but we've already said we can't answer "half-True." Common sense would say
that even though part of the sentence is True, overall it is False. The
same analysis applies to:

5. It is blue and it is a ball.

This next one is tricky:

6. It is red and it is blue.

At the risk of being Clintonian, here we have to say it depends on what the
meaning  of "is" is. "Is" could mean "is totally", "is mostly" or "is
partially." Let's say that "is" means "is totally," so that a ball with red and
blue stripes would neither be totally red nor totally blue. In that case,
something can't be totally red and totally blue at the same time and in the
same way, so we have to say false.

7. It is red and it is red.

This is redundant, so the answer is the same as that to "It is red." which
is true.

Now one thing we have to recognize is that the words "True" and "False" aren't
special. They're just English words. In French they're "Vrai" and "Faux," which
I rather like better because they are the same number of letters (easier to
vertically align). The important thing is the meaning of "True" and "False" not
the symbol.

We could just as easily change the symbols to `1` for "True" and `0` for
"False." In fact, that's what all the famous "zeros" and "ones" are in
computing; little switches that can be toggled in the "True" or `1` position,
or in the "False" or `0` position.

# Binary Logic

Binary logic is exactly like what we did above with the red ball, only here
the sentences look like this:

```
1 AND 1
1 AND 0
```

We can also tighten up our notions of what `AND` means by listing
out all the possibile ways that `AND` can combine two statements based on
whether those statements are true or false. Since there are two statments that
each have two possibile truth-values (`True` or `False`), there are only four
possible ways (`2 * 2 = 4`)statements can be combined with an `AND`:

```
True  AND True  = True
True  AND False = False
False AND True  = False
False AND False = False
```
This is called the "truth-table" of `AND`. We can think of it as taking two
arbitrary inputs, call them `A` and `B`, that could be either `True` or `False`
and then listing out what happens in every combination of `A` and `B`:

| A     | B     | AND   |
| ----- | ----- | ----- |
| True  | True  | True  |
| True  | False | False |
| False | True  | False |
| False | False | False |

Since `True` and `False` are just symbols, we can use `T` for `True` and `F`
for `False`:

| A   | B   | AND |
| --- | --- | --- |
| T   | T   | T   |
| T   | F   | F   |
| F   | T   | F   |
| F   | F   | F   |

Or we can use `1` for `True` and `0` for `False`:

| A   | B   | AND |
| --- | --- | --- |
| 1   | 1   | 1   |
| 1   | 0   | 0   |
| 0   | 1   | 0   |
| 0   | 1   | 0   |

All these tables say the same thing.

The 16 binary logic gates are:

| A x B          | True True | True False | False True | False False |
| -------------- | --------- | ---------- | ---------- | ----------- |
| TRUE           | **True**  | **True**   | **True**   | **True**    |
| OR             | **True**  | **True**   | **True**   | False       |
| IMPLIEDBY      | **True**  | **True**   | False      | **True**    |
| A              | **True**  | **True**   | False      | False       |
| IMPLY          | **True**  | False      | **True**   | **True**    |
| B              | **True**  | False      | **True**   | False       |
| EQ (XNOR)      | **True**  | False      | False      | **True**    |
| AND            | **True**  | False      | False      | False       |
| NAND           | False     | **True**   | **True**   | **True**    |
| NEQ (XOR)      | False     | **True**   | **True**   | False       |
| NOT B          | False     | **True**   | False      | **True**    |
| NOT IMPLY      | False     | **True**   | False      | False       |
| NOT A          | False     | False      | **True**   | **True**    |
| NOT IMPLIED BY | False     | False      | **True**   | False       |
| NOR            | False     | False      | False      | **True**    |
| FALSE          | False     | False      | False      | False       |

This seems like a lot of detail, but keep in mind that the bottom half
(everything from NAND to FALSE is just the negation of the top half).

[To Be Expanded Upon]

# Canonical implementations of Booleans:

## AND

```
NOT(A NAND B)
```

## OR
```
(NOT A) NAND (NOT B)
```

## NOR
```
NOT(A OR B)
```

## True
```
A OR (NOT A)
```

## False

```
NOT (A OR (NOT A))
```

## IMPLY

```
(NOT A) OR B
```

## IMPLIED BY

```
(NOT B) OR A
```

## EQ

```
(A AND B) OR (A NOR B)
```

# NEQ

```
NOT (A EQ B)
```

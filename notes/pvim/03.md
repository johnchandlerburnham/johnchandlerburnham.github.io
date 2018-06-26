---
title: "Notes (PVIM 03/21): Insert Mode"
author: jcb
date: 2018-06-18
tags: workthrough, programming, tools
---

# Chapter 3: Insert Mode

## Make Corrections Instantly from Insert Mode

- `<C-h>` Delete back one character
- `<C-w>` Delete back one word
- `<C-u>` Delete back to start of line

These bindings also work in POSIX shells like bash or zsh.

## Get Back to Normal Mode

| Mode   | Key     | Effect                       |
|--------|---------|------------------------------|
| Insert | `<Esc>` | Switch to Normal mode        |
| Insert | `<C-[>` | Switch to Normal mode        |
| Insert | `<C-o>` | Switch to Insert Normal mode |

"Insert Normal mode" executes a single command in Normal mode and automatically
returns to insert mode. I don't find this to be tremendously useful, generally,
since it doesn't actually preserve the Insert mode session for e.g. the `.`
command (only the second insertion gets remembered). It's also
complicated to remember, because `<Ctrl-o>` in normal mode is a lot more
useful (moves cursor to the previous "jump", like when following links in
the help files). Also, if you've remapped the Caps Lock key to behave as
`<Esc>` like I have, the "cost" of leaving Insert mode the normal way goes
way down.

That being said sometimes it's nice to be able to adjust the scroll without
leaving insert mode though:

| Mode   | Key  | Effect                            |
|--------|------|-----------------------------------|
| Normal | `zz` | scroll cursor to middle of screen |
| Normal | `zt` | scroll cursor to top of screen    |
| Normal | `zb` | scroll cursor to bottom of screen |


## Remap the Caps Lock Key

Some people argue for remapping Caps Lock to `<Esc>`, others argue that it
should be `<Ctrl>`. Proponents of `<Esc>` say that it's one of the most
commonly used keys in Vim, so it makes sense for it to be on the home row.
On the other hand, some people, like Drew Neil, prefer `<Ctrl>` because
it makes all the Ctrl key chords easier, including `<Ctrl-[>` which is
synonymous with `<Esc>`. After all, `vi` (the precursor to vim) was originally
designed for a keyboard that had `<Ctrl>` to the left of the `A` key.

---

<p align="center">
<img src="/images/KB_Terminal_ADM3A.svg"
     alt="ADM3A"
     width = 700px>
</p>

---

*The keyboard of the [ADM-3A](https://en.wikipedia.org/wiki/ADM-3A), one of the
first video display terminals.*

---

Incidentally, another neat factoid relating to the ADM-3A's keyboard is
that the `~` key was labeled "Home", which is why the `~` character
is a shortcut to your home directory in shells like bash or zsh.

There are good arguments on both sides, but my solution is to map `Caps Lock`
to `Esc` (and vice-versa), and to use a keyboard like the Kinesis Advantage
or the Keyboardio that puts the modifier keys under the thumbs the way
God intended.

---

<p align="center">
<img src="/images/keyboardio.jpg"
     alt="Keyboardio"
     width = 571px>
</p>

---

*The [Keyboardio](https://shop.keyboard.io/): Beautiful, Functional, Sane*

---

Seriously, hasn't it ever occured to you how silly it is that the only things
your thumbs do on the standard QWERTY layout is hit the spacebar? I understand
it's the most common key, but does it really need to be ten times the size
and be manned by your two strongest digits? It's preposterous that your weakest
digits, the pinky fingers, are responsible for a dozen different keys each,
but your thumbs share only one.

And, of course, when you're using a sensible keyboard that already has `<Ctrl>`
under a thumb, it makes sense to move `<Esc>` by a pinky on the home row.

## Paste from a Register Without Leaving Insert Mode

| Mode   | Key          | Effect                                   |
|--------|--------------|------------------------------------------|
| Insert | `<C-r>`      | paste from a `{register}`                |
| Insert | `<C-r><C-p>` | paste from a `{register}` and fix indent |

## Do Back-of-the-Envelope Calculations in Place

| Mode   | Key      | Effect                                  |
|--------|----------|-----------------------------------------|
| Insert | `<C-r>=` | evaluate an expression and paste result |

This is a really neat feature! I often find myself using Google as a quick
calculator when writing and it'd be much faster to just use the editor directly.

## Insert Unusual Characters by Character

| Mode   | Key                   | Effect                               |
|--------|-----------------------|--------------------------------------|
| Insert | `<C-v>{123}`          | insert character by decimal code     |
| Insert | `<C-v>u{1234}`        | insert character by hexadecimal code |
| Insert | `<C-v>`{nondigit}     | insert character literally           |
| Insert | `<C-k>{char1}{char2}` | insert character by digraph          |

## Insert Unusual Characters by Digraph

So, this feature is surprisingly good. You'd think that memorizing digraphs
would just be unnecessary detail versus memorizing character codes, but
in a lot of cases the digraphs have a kind of mnemonic logic that makes
them dramatically superior.

Let's say I want to type some Greek letters (I dunno, for math and stuff),
like π, or ζ, or α. Well, the digraphs for all the Greek letters are usually
just their corresponding Latin letters followed by an asterisk (usually, because
some Greek letters like ψ don't have a corresponding Latin letter):

| Mode   | Key      | Effect   |
|--------|-----------|----------|
| Insert | `<C-k>p*` | insert π |
| Insert | `<C-k>z*` | insert ζ |
| Insert | `<C-k>a*` | insert α |
| Insert | `<C-k>q*` | insert ψ |

You can also use digraphs as arguments for commands like `f` (if the
digraph-arg option is enabled), which is also super useful!

Assuming you only have to occasionally deal with special characters,
this is dramatically easier than having to fiddle with keyboard layers.

## Overwrite Existing Text with Replace Mode

| Mode   | Key | Effect                         |
|--------|-----|--------------------------------|
| Normal | r   | replace single character       |
| Normal | gr  | replace virtual characters     |
| Normal | R   | enter Replace mode (overwrite) |
| Normal | gR  | enter Virtual Replace mode     |

The replace command is an old standby. A surprising number of changes and
typos are only single character errors, and typing `r{char}` instead of
`xi{char}<Esc>` saves two whole strokes! What's more is that since `r` is an
index finger key in QWERTY, we get to turn the three weaker strokes of `x` (ring
finger), `i` (ring finger), and `<Esc>` (pinky) into a single strong stroke! You
might be tempted to dismiss this as silly bean-counting, but it's through
thousands of tiny improvements like this that we can stave off repetitive strain
injury.

Replace mode is primarily useful when the existing text and your modification
have the same number of characters. For example, if I wanted to change the
number `97` to the number `62`, replace mode might be a tool I'd reach for,
since `62` and `97` have the same number of characters. In my opinion,
however, it's much less useful than the `c` change command
(like `caw` for "change a word") is vastly more intuitive and flexible. The
example in the book could have been accomplished with `)cge` (go to the
next sentence and change to the end of the previous word), or even better
with `)cvb` (go to the next sentence and change in a visual block that
includes the current character to the beginning of the previous word). Note
that the previous word is the `.`, so `b` and `ge` end up on the same character.

The difference between the two in this case is that `b` is an exclusive motion,
and `ge` is an inclusive motion, so if our cursor is on the `B` in `But` in
the example (`the line. But in`), a `cge` will include the `B`, but a `cb`
won't. However, we can turn an exclusive motion into an inclusive one by
using a visual block with `v`.

Now, why do all this instead of using Replace? Because the grammar
for making changes on text objects is much more powerful and expressive. Let's
say we know how to do the `)cvb` command described above. On it's own, the two
sequences to turn `the line. But` into `the line, but` look about the same:

```
)cvb, b<Esc>
f.R, <Esc>
```

Actually, the sequence using Replace is one character shorter. But suppose
instead of just changing the `.` to a comma we wanted to change the whole word
`line` to the word `text` as well. Here are two sequences that accomplish that

```
)cvBtext, b<Esc>
flRtext, <Esc>
```

And now if we wanted to change the previous 2 words from `a line` to `some
text`:

```
)cv2Bsome text, b<Esc>
ft;;Rsome text,b<Esc>i<Space><Esc>
```

This is maybe a little hard to see on the page, so I encourage you to try the
above sequences for yourself. What you'll find is that the efficiency of Replace
mode is highly dependent on what the text says and what changes you want to make.
Changing `line. B` to `text, b` works great, because the number of letters is
the same in both. But if you try to change `the line. B` to `some text, b`,
the Replace goes off by one and you have to escape out of it and then make
a second edit.

Furthermore, how efficiently we can get to our cursor to the
right place to start our Replace mode is totally dependent on the previous text.
This is why we could do `fl` to jump the first letter of `line`, but had to do
`ft;;` to jump to the `t` in `the` (there were two closer `t` characters).

By contrast, the change grammar was nearly unchanged from example to
example because it more closely expresses the common pattern in all of them:

"Combine two sentences by changing the end of the first and the beginning of
the second."

### Overwrite Tab Characters with Virtual Replace Mode

Virtual replace mode is, in my opinion, useless if you have already done the
sensible thing and banished the `<Tab>` character from your buffers,
by setting the `expandtab` option in your .vimrc (which converts all tabs
to spaces).

Yes, I know that the tabs vs spaces debate is one of the great Holy Wars of
programming, and that there are many brilliant people on the other side. In the
specific context of Vim, though, I think spaces are a clear winner, since
navigating multiple whitespace characters is trivial with `^` or `w`, and it's
much nicer to have one column in the buffer represent one character in the file.

Using spaces also lets you do nice things like forget about the subtle
distinctions between `Replace` and `Virtual Replace`, which frees up valuable
brainspace.





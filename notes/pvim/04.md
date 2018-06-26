---
title: "Notes (PVIM 04/21): Visual Mode"
author: jcb
date: 2018-06-18
tags: workthrough, programming, tools
---

# Chapter 4: Visual Mode

## Grok Visual Mode

Visual mode in vim is analogous to text selection in other editors.  There are
three different types of Visual mode:

| Mode   | Key     | Effect                              |
|--------|---------|-------------------------------------|
| Normal | `v`     | switch to characterwise-visual mode |
| Normal | `V`     | switch to linewise-visual mode      |
| Normal | `<C-v>` | switch to blockwise-visual mode     |

The important thing to keep in mind with Visual mode is that when we select text
in it, commands that would take a motion in normal mode (like `d` or `c`) will
instead operate on our selection. So `daw` (delete a word) and `vawd`
(visual-select a word and delete) do the same thing. The only difference between
the two is if that visual mode always selects the character the cursor is on, so
`v` can turn character exclusive motions like `b` or `h` into character
inclusive motions. For example, `dh` deletes the character to the left of the
cursor, but `dvh` deletes the character to the left of the cursor and also the
character under the cursor).

### Meet Select Mode

On second thought let's not meet select mode, 'tis a silly place.

todo: https://i.imgur.com/sbuOHyB.png

Seriously, you don't need to know this. I'm not even going to write down the
commands; you'll never need to use them, except maybe if you're using a plugin
(like for code snippets) that relies on Select mode.  However, in that case
you'll want to learn how to use Select mode from the plugin docs, since the
plugin will almost certainly modify the mode's behavior.

## Define a Visual Selection

| Mode   | Key     | Effect                              |
|--------|---------|-------------------------------------|
| Normal | `gv`    | reselect last visual selection      |
| Visual | `v`     | switch visual to characterwise mode |
| Visual | `V`     | switch visual to linewise mode      |
| Visual | `<C-v>` | switch visual to blockwise mode     |
| Visual | `o`     | go to other end of selected text    |

## Repeat Line-Wise Visual Commands

Firstly, manually setting 'shiftwidth' and 'softtabstop' is unnecessary if
you've already set 'filetype indent on', which automatically changes indentation
settings based on the type of file you're editing.

Secondly, the sequence to do double indents in the example is great. Yes,
you can do `2>` instead of `>.`, but honestly I don't like counting. When you
indent one level at a time you gain a lot of optionality, because the `>`
command gets put in the `.` (previous command) register. Want to indent one
more? Press `.` again. One less? Undo with `u`.

On the other hand, using visual mode here at all is a little questionable, since
`>` already takes a motion, so `>j.` is simpler. But often there isn't a great
way to move to the end of the selection you want to indent (without counting,
which I hate). In that case I would use linewise visual mode from the start of
the selection I wanted, try to jump as close as possible to the end, and make
adjustments with `j` and `k`, or maybe with another motion.

## Prefer Operators to Visual Commands Where Possible

| Mode   | Key  | Effect                   |
|--------|------|--------------------------|
| Visual | `u`  | make selection lowercase |
| Visual | `U`  | make selection uppercase |
| Normal | `gu` | make {motion} lowercase  |
| Normal | `gU` | make {motion} uppercase  |

This section reiterates the lesson that making changes with text objects motions
is usually better than using visual mode when we want the changes to be
repeatable.

On the other hand, visual mode is sometimes better when we're unsure of what
change we want to make and want to try something out incrementally, like with
the indents in the previous section.

## Edit Tabular Data with Visual-Block Mode

Visual-block mode is very very very useful whenever you're dealing with text
that's aligned in columns. Think about it like this, A file is a grid of
characters arranged in lines and columns, so we have three different visual
modes: one for characters, one for lines, and one for columns. Columns and lines
have very different properties though, because a file isn't just any grid of
characters, but rather a grid that usually has a particular kind of shape: Files
are usally taller than they are wide.

What I mean by that is that a file's width usually doesn't grow as much as its
height. I personally try to limit all my text files to a width of 80 characters,
because I think it's more readable, but some people prefer width-limits of 100,
or 120.  Regardless of the particular width limit, there is a general convention
that text should flow down the page more than across the screen, which makes a
line in a file tend to be a smaller and more meaningful unit of text than a
whole column from the top of a file to the bottom. The content of text is also
always aligned along its lines, and only sometimes meaninfully aligned along its
columns.

Because of these differences between lines and columns, Visual line mode and and
Visual block mode (columns) behave differently. Visual line mode selects whole
lines by default, whereas in visual block mode, you have to specify how tall the
columns should be.

## Change Columns of Text

Another difference between visual line and visual block mode is how they
interact with different operations. Characterwise commands like `r` or `x`
work basically the same in both, where they are "mapped" over each character in
the selection. So selecting a line or a column and doing `r*` will replace each
character in the line or column with `*`. However, something like entering
insert-mode with `I` (capitalized so as not to conflict with the `i` for inner
in e.g. `iw`) or `c` will only map the changes over the selected lines in Visual
block mode. In Visual line mode, going into insert mode only adds text in one
place at the starting point of the selection.

## Append After a Ragged Visual Block

| Mode   | Key | Effect                                  |
|--------|-----|-----------------------------------------|
| Visual | `I` | enter insert mode at start of selection |
| Visual | `A` | enter insert mode at end of selection   |



---
title: "Notes: Practical Vim by Drew Neil"
author: jcb
date: 2018-06-18
tags: workthrough, programming, tools
---

# Contents

----

-  **Completed**
-  *In Progress*
-  Planned

----

- [Chapter 01: The Vim Way](/notes/pvim/01.html)
- [Chapter 02: Normal Mode](/notes/pvim/02.html)
- [Chapter 03: Insert Mode](/notes/pvim/03.html)
- [Chapter 04: Visual Mode](/notes/pvim/04.html)
- [Chapter 05: Command-Line Mode](/notes/pvim/05.html)
- Chapter 06: Manage Multiple Files
- Chapter 07: Open Files and Save them to Disk
- Chapter 08: Navigate Inside Files with Motions
- Chapter 09: Navigate Between Files with Jumps
- Chapter 10: Copy and Paste
- Chapter 11: Macros
- Chapter 12: Matching Patterns and Literals
- Chapter 13: Search
- Chapter 14: Substitution
- Chapter 15: Global Commands
- Chapter 16: Index and Navigate Source Code with ctags
- Chapter 17: Compile Code and Navigate Errors with the Quickfix List
- Chapter 18: Search Project-Wide with grep, vimgrep and Others
- Chapter 19: Dial X for Autocompletion
- Chapter 20: Find and Fix Typos with Vim's Spell Checker
- Chapter 21: Now What?
- Appendix 1: Customize Vim to Suit Your Preferences


# Preliminaries

**Commands**:

| Command            | Action                |
|--------------------|-----------------------|
| `:help` `:h`       | display help file     |
| `:substitute` `:s` | search and replace    |
| `vimtutor`         | teaches basic vim use |


## How The Book is Structured

Each chapter covers a theme proceeding from novice to advanced within the
chapter.

Not designed to be read in order, but that's what I'm going to do anyway.

**How My Notes are Structured**:

Each chapter gets a markdown file, every tip gets a section. The commands
covered in the chapter will be listed at the top of each chapter note file.

Interspersed in each section will be my commentary.

## Learn to Touch Type, Then Learn Vim

Seriously, learn to touch type. It's actually super fun and satisfying. It's
also the single biggest piece of low-hanging productivity fruit
you can pluck. You don't have to be a 100 wpm or even an 80 wpm typist. I type
at 60 wpm, but 40 is totally fine. It's not about the speed, it's about the
fluidity of thought that comes from looking at what you're doing on the screen
rather than at your hands. It's about willing a word to appear in front of you
and having your fingers magically move to make it happen.

It's about making the machine an extension of your mind. Which also why we learn
vim.

## Read the Forgotten Manual

The Vim documentation is delightful. Truly delightful. Our world of software
is a barren wasteland where ravaging hordes of brogrammers prowl in the darkness,
pouncing on unwary beginners with cries of "git gud, scrub". But there are rare
pockets of civilization in this wilderness, oases to shelter the weary traveler,
and one of the best of these is the Vim documentation. It is plainly written, it
is comprehensive, it is tastefully formatted and organized, it is perfectly
integrated into the software it is documenting. Rejoice, developers, and weep,
for you will rarely have it this good.

## Notation for Simulating Vim on the Page

| Notation          | Meaning                                    |
|-------------------|--------------------------------------------|
| `x`               | press 'x' once                             |
| `dw`              | press `d` then `x`                         |
| `dap`             | press `d`, `a`, `p`                        |
| `<C-n>`           | `<Ctrl>` and `n`                           |
| `f{char}`         | `f` then any character                     |
| `f{a-z}`          | `f` then any lowercase letter              |
| `f{a-zA-Z}`       | `f` then any lowercase or uppercase letter |
| `d{motion}`       | `d` then any motion command                |
| `<C-r>{register}` | `<Ctrl>` and `r`, then a register address  |
| `<C-w><C-j>`      | `<C-w>` then `<C-j>`                       |
| `<Esc>`           | Escape key                                 |
| `<CR>`            | Enter key (CR stands for Carriage Return)  |
| `<S-Tab>`         | `<Shift>` and `<Tab>` at the same time     |

---

| Prompt            | Meaning                                    |
|-------------------|--------------------------------------------|
| `$`               | system shell outside vim                   |
| `:`               | Command-Line mode Ex command               |
| `/`               | Forward search                             |
| `?`               | Backward search                            |
| `=`               | Command-Line mode evaluate Vim script      |

All the cursor position notation is intuitive. It looks exactly like what
happens in-editor.

## Use Vim's Factory Settings

How about no? I like my `.vimrc`. If I find a mismatch while doing any exercises
(unlikely, my .vimrc is pretty minimal), then and only then will I run `vim -u
NONE -N`.

## Vim in the Terminal or GUI

Terminal. Obviously terminal. Vastly superior in its integration with the shell
environment.



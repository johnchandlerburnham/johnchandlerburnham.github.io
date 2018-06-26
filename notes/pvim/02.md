---
title: "Notes (PVIM 02/21): Normal Mode"
author: jcb
date: 2018-06-18
tags: workthrough, programming, tools
---

# Tip 7: Pause with Your Brush Off the Page

- Normal Mode is resting state

# Tip 8: Chunk Your Undos

- Return to normal mode to create a logical "change" unit that could be undone
- `<Esc>o` instead of `<CR>` opens a new line in a separate change unit
- Arrow keys in insert mode create a new undo chunk

# Tip 9: Compose Repeatable Changes

- `daw` delete a word

# Tip 10: Use Counts to Do Simple Arithmetic

- `<C-a>` add [count] to the number at or after the cursor
- `<C-x>` subtract [count] to the number at or after the cursor

# Tip 11: Don't Count If You Can Repeat

- using `.` and repeating commands creates a more granular undo history
- doing addition in ones head is also tedious
- but using numbers can be better if chunking the individual commands makes
  little sense

# Tip 12: Combine and Conquer

- Operator + Motion = Action

| Mode   | Key    | Effect                          |
|--------|--------|---------------------------------|
| Normal | `c`    | change {motion}                 |
| Normal | `d`    | delete {motion}                 |
| Normal | `daw`  | delete a word                   |
| Normal | `dap`  | delete a paragraph              |
| Normal | `gu`   | make {motion} lowercase         |
| Normal | `gU`   | make {motion} uppercase         |
| Normal | `gUaw` | make a word uppercase           |
| Normal | `gUU`  | make line uppercase             |
| Normal | `~`    | swap case under cursor          |
| Normal | `g~`   | swap case for {motion}          |
| Normal | `>`    | shift indent right for {motion} |
| Normal | `<`    | shift indent left for {motion}  |
| Normal | `<<`   | shift line indent left          |

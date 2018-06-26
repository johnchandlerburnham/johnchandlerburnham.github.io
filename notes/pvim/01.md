---
title: "Notes (PVIM 01/21): The Vim Way"
author: jcb
date: 2018-06-18
tags: workthrough, programming, tools
---

# Chapter 1: The Vim Way

### Tip 1: Meet the Dot Command

 | Mode | Key    | Effect                            |
 |------|---------|-----------------------------------|
 | N    | `.`     | repeat last change                |
 | N    | `u`     | undo last change                  |
 | N    | `d`     | delete `{motion}`                 |
 | N    | `dd`    | delete line                       |
 | N    | `>`     | indent `{motion}`                 |
 | N    | `>G`    | increase indent until end of file |
 | N    | `i`     | enter insert mode                 |
 | I    | `<Esc>` | exit insert mode                  |

### Tip 2: Don't Repeat Yourself

 | Mode | Key | Effect                                |
 |------|------|---------------------------------------|
 | N    | `$`  | move to end of line (buck stops here) |
 | N    | `a`  | append after current position"        |
 | N    | `A`  | `$a` append at end of line            |
 | N    | `c`  | `c` change text                       |
 | N    | `C`  | `c$` change to end of line            |
 | N    | `s`  | `cl` substitute one to right          |
 | N    | `S`  | `^C` substitute line                  |
 | N    | `I`  | `^i` insert at start of line          |
 | N    | `o`  | `A<CR>` open a new line               |
 | N    | `O`  | `ko` open a new line above            |

### Tip 3: Take One Step Back, Then Three Forward

 | Mode | Key | Effect             |
 |------|------|--------------------|
 | N    | `s`  | substitute         |
 | N    | `f`  | find a character   |
 | N    | `;`  | repeat last search |

### Tip 4: Act, Repeat, Reverse

 | Mode | Key           | Effect                             |
 |------|----------------|------------------------------------|
 | N    | `@:`           | repeat Ex command                  |
 | N    | `&`            | repeat last :s[ubstitute] command  |
 | N    | `t`            | toward (one before) a character    |
 | N    | `F`            | find backwards                     |
 | N    | `T`            | toward backwards                   |
 | N    | `n`            | repeat `/` or `?` search           |
 | N    | `N`            | repeat `/` or `?` search backwards |
 | N    | `qx{changes}q` | quote changes as "x"               |
 | N    | `@x`           | repeat changes quoted as `x`       |

### Tip 5: Find and Replace by Hand

 | Mode | Key  | Effect          |
 |------|-------|-----------------|
 | N    | ``*`` | search for word |

### Tip 6: Meet the Dot Formula

- {move}{execute} pattern. One keystroke to move, one to make a change. e.g.
`n.` or `;.`


---
title: "Notes (TDDI 01/15): Overview"
author: jcb
date: 2018-08-03
tags: tddi, notes, idris
---

# Preface

- Software is unreliable
- Types constrain the behaviour of software
- Dependent types constrain software based on the concrete values the program
  operates on.
- Constrained software is software that has less space to fail.

## Acknowledgments

Related technologies to Idris: Haskell, Epigram, Agda, Coq

## About this book

- Part 1 (Chapters 01-02) introduces concepts and gives a tour of Idris
- Part 2 (Chapters 03-10) introduces the core language features
- Part 3 (Chapters 11-15) describes some applications of Idris

# Part 1: Introduction

- Two most distinctive parts of Idris are *typed-holes*, which let you
  investigate what the types should be for parts of the program that haven't
  been written yet, and *first-class type*, which is being able to manipulate
  types in your code in the same way you can manipulate values.

## Installing Idris on NixOS with Vim

```
Λ → nix-env -iA nixos.idris
Λ → idris
```



# Chapter 1: Overview




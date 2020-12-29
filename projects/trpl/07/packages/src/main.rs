use std::{
  cmp::Ordering,
  io::{self, Write},
};

mod sound {
  pub mod instrument {
    pub mod woodwind {
      pub fn clarinet() {
        // function body
        super::breathe_in();
        crate::sound::instrument::breathe_in();
        println!("I am a clarinet!");
      }
    }

    pub mod string {
      pub fn guitar() {
        // function body
        println!("I am a guitar!");
      }
    }

    pub fn breathe_in() {
      println!("inhale");
    }
  }
}

mod plant {
  pub struct Vegetable {
    pub name: String,
    id: i32,
  }

  impl Vegetable {
    pub fn new(name: &str) -> Vegetable {
      Vegetable {
        name: String::from(name),
        id: 1,
      }
    }
  }
}

mod separate_file;

use crate::sound::instrument::woodwind;
use crate::sound::instrument::woodwind::clarinet;

fn main() {
  crate::sound::instrument::woodwind::clarinet();
  woodwind::clarinet();
  clarinet();
  sound::instrument::string::guitar();

  let mut v = plant::Vegetable::new("squash");

  v.name = String::from("butternut squash");
  println!("{} are delicious", v.name);

  // println!("The ID is {}", v.id);
  separate_file::do_something();
  separate_file::separate_file_module::do_another_thing();
}

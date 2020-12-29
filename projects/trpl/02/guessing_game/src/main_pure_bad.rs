use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
  println!("Guess the number!");

  let secret_number = rand::thread_rng().gen_range(1, 101);

  println!("The secret number is: {}", secret_number);
  loop_(secret_number);

}

fn loop_(secret : u32) -> u32 {
    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin().read_line(&mut guess)
      .expect("Failed to read line");

    let guess: u32 = match guess.trim().parse() {
        Ok(num) => num,
        Err(_) => loop_(secret),
      };

    println!("You guessed: {}", guess);

    match guess.cmp(&secret) {
      Ordering::Less => {println!("Too small!"); loop_(secret) }
      Ordering::Greater => { println!("Too big!"); loop_(secret) }
      Ordering::Equal => { println!("You win!"); return guess; }
    }
  }


enum Coin {
  Penny,
  Nickel,
  Dime,
  Quarter(UsState),
}

#[derive(Debug)]
enum UsState {
  Alabama,
  Alaska,
  Other,
}

fn value_in_cents(coin: Coin) -> u32 {
  match coin {
    Coin::Penny => 1,
    Coin::Nickel => 5,
    Coin::Dime => 10,
    Coin::Quarter(state) => 25,
  }
}

fn plus_one(x: Option<i32>) -> Option<i32> {
  match x {
    None => None,
    Some(i) => Some(i + 1),
  }
}

fn value_in_cents_(coin: Coin) -> u32 {
  match coin {
    Coin::Penny => {
      println!("Lucky penny!");
      1
    }
    Coin::Nickel => 5,
    Coin::Dime => 10,
    Coin::Quarter(state) => {
      println!("State quarter  from {:?}!", state);
      25
    }
  }
}

fn main() {
  let five = Some(5);
  let six = plus_one(five);
  let none = plus_one(None);

  println!("five is {:?}", five);
  println!("six is {:?}", six);
  println!("none is {:?}", none);
}

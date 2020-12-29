fn main() {
  let x = 5;
  println!("The value of x is: {}", x);
  let x = 6;
  println!("The value of x is: {}", x);

  let x = 5;
  let x = x + 1;
  let x = x + 2;
  println!("The value of x is: {}", x);

  let spaces = "  ";
  let spaces = spaces.len();

  println!("The value of spaces is: {}", spaces);

  // u8 overflow
  let x : u8 = 255;
  println!("The value of x is: {}", x);
  //  let x : u8 = x + 1;
  // println!("The value of x is: {}", x);

  let x = 2.0;
  println!("The value of x is: {}", x);

  let y: f32 = 3.0;
  println!("The value of y is: {}", y);

  let sum = 5 + 10;
  println!("The value of sum is: {}", sum);

  let product = 4 * 30;
  println!("The value of product is: {}", product);

  let quotient = 56.7 / 32.2;
  println!("The value of quotient is: {}", quotient);

  let remainder = 43 % 5;
  println!("The value of remainder is: {}", remainder);

  let t = true;

  let f: bool = false;

  let c = 'z';
  let z = 'ℤ';
  let heart_eyed_cat = '😻';
  println!("The value of heart cat is: {}", heart_eyed_cat);

  let tup: (i32, f64, u8) = (500, 6.4, 1);

  let (x, y, z) = tup;

  println!("The value of y is: {}", y);

  let x : (i32, f64, u8) = (500, 6.4, 1);

  let five_hundred = x.0;

  let six_point_four = x.1;

  let one = x.2;

  let a = [1,2,3,4,5];

  // let a6 = a[6];
  // println!("The value of a6 is: {}", a6);
  let index = 10;

  //let element = a[index];

  //println!("The value of element is: {}", element);

  macro_rules! id {
    ($e:ident) => ($e);
  }

  println!("id(index) is: {}", id!(index));

//  let element = a[id!(index)];

  f1();
  f2(5);
  f3(5,6);

  let x = { let y = 6; y};
  println!("The value of x is: {}", x);

  let x:() = {let y = 6;};

  let x = five();
  println!("The value of x is: {}", x);

  let x = if {let x = false; x} { () } else { () };
  let x = if {let x = true; x} { () };
  let x = if {let x = true; x} { 3 } else { 4 };
  let x = if {let x = false; x} {;} else {;};
  //println!("The value of x is: {}", x);
  //
  let a = [1,2,3,4];

  for x in a.iter().rev() {
    for y in a.iter() {
      println!("x: {}, y: {}", x, y);
    }
  }
  println!("f {} to c {}", 0.0, farenheit_to_celsius(0.0));
  println!("f {} to c {}", 32.0, farenheit_to_celsius(32.0));
  println!("f {} to c {}", 212.0, farenheit_to_celsius(212.0));

  println!("c {} to f {}", 0.0, celsius_to_farenheit(0.0));
  println!("c {} to f {}", 100.0, celsius_to_farenheit(100.0));
  println!("c {} to f {}", -40.0, celsius_to_farenheit(-40.0));

  for x in -1..5 {
   println!("The value of fib(x) is: {}", fib(x));
  }
}

fn farenheit_to_celsius (x : f32) -> f32 {
    (x - 32.0) * 100.0/180.0
}
fn celsius_to_farenheit (x : f32) -> f32 {
    x * 180.0/100.0 + 32.0
}

fn fib (x : i64) -> i64 {
  match x {
    0 | 1 => 1,
    n if n < 0 => 0,
    _ => fib(x - 1) + fib (x - 2)
  }
}


fn five() -> i32 {
  5
}
fn f1() {
    println!("Another function.");
}

fn f2(x: i32) {
  println!("The value of x is: {}", x);
}

fn f3(x:i32, y:i32) {
  println!("The value of x is: {}", x);
  println!("The value of y is: {}", y);
}


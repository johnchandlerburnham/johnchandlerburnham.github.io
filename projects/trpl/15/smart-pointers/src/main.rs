use std::ops::Deref;

#[derive(Debug)]
enum List {
  Cons(i32, Box<List>),
  Nil,
}

enum Message {
  Quit,
  Move { x: i32, y: i32 },
  Write(String),
  ChangeColor(i32, i32, i32),
}

fn cons(x: i32, xs: List) -> List { List::Cons(x, Box::new(xs)) }

struct MyBox<T>(T);

impl<T> MyBox<T> {
  fn new(x: T) -> MyBox<T> { MyBox(x) }
}

impl<T> Deref for MyBox<T> {
  type Target = T;

  fn deref(&self) -> &T { &self.0 }
}

fn hello(name: &str) {
  println!("Hello, {}!", name);
}

struct CustomSmartPointer {
  data: String,
}

impl Drop for CustomSmartPointer {
  fn drop(&mut self) {
    println!("Dropping CustomSmartPointer with data `{}`!", self.data);
  }
}

fn main() {
  let b = Box::new(5);
  println!("b = {}", b);

  let list = cons(1, cons(2, cons(3, List::Nil)));
  println!("list = {:?}", list);

  let x = 5;
  let y = &x;

  assert_eq!(5, x);
  assert_eq!(5, *y);

  let x = 5;
  let y = MyBox::new(x);

  assert_eq!(5, x);
  assert_eq!(5, *y);

  let m = MyBox::new(String::from("Rust"));
  hello(&m);

  let c = CustomSmartPointer { data: String::from("my stuff") };

  let d = CustomSmartPointer { data: String::from("other stuff") };

  println!("CustomSmartPointers created.");

  let c =  CustomSmartPointer {
     data: String::from("some data"),
  };

  println!("CustomSmartPointer c created.");
  drop(c);
  println!("CustomSmartPointer c dropped before the end of main.");
}

#[allow(dead_code)]
#[derive(PartialEq)]
struct User {
  username: String,
  email: String,
  sign_in_count: u64,
  active: bool,
}

#[allow(dead_code)]
#[allow(unused_variables)]
fn main() {
  let user1 = User {
      email: String::from("someone@example.com"),
      username: String::from("someusername123"),
      active: true,
      sign_in_count: 1,
  };

  let mut user1_ = User {
    email: String::from("someone@example.com"),
    username: String::from("someusername123"),
    active: true,
    sign_in_count: 1,
  };

  println!("user's email is: {}", user1_.email);

  user1_.email = String::from("anotheremail@example.com");

  println!("user's email is: {}", user1_.email);

  let user2 = User {
    email: String::from("another@example.com"),
    username: String::from("anotherusername567"),
    active: user1.active,
    sign_in_count: user1.sign_in_count,
  };

  let user2_ = User {
    email: String::from("another@example.com"),
    username: String::from("anotherusername567"),
    ..user1
  };

  println!("user2_ == user2: {}", user2 == user2_);

  struct Color(i32, i32, i32);
  struct Point(i32, i32, i32);

  let black = Color(0,0,0);
  let origin = Point(0,0,0);

}

fn build_user (email: String, username: String) -> User {
  User {
    email,
    username,
    active: true,
    sign_in_count: 1,
  }
}

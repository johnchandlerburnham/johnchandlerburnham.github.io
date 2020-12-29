fn main() {

  { let s = "hello";
    println!("s in scope: {}", s);
  }
  // println!{"s not in scope: {}", s);

  { let mut s = String::from("hello");
    s.push_str(", world!");

    println!("{}", s);
  }

  { let s1 = String::from("hello");
//    let s2 = s1;
    println!("{}, world", s1);
  }

  { let s = String::from("hello");
    takes_ownership(s);

//    takes_ownership(s); // s hase moved out of scope

    let x = 5;

    makes_copy(x);
  }

  { let s1 = gives_ownership();
    let s2 = String::from("hello");
    let s3 = takes_and_gives_back(s2);
  }

  { let s1 = String::from("hello");

    let (s2, len) = calculate_length(s1);

    println!("The length of '{}' is {}.", s2, len);
  }

  { let s1 = String::from("hello");
    let len = calculate_length_ref(&s1);
    println!("The length of '{}' is {}.", s1, len);
  }

  { let mut s = String::from("hello");
    change(&mut s);
  }

  { let mut s = String::from("hello");
    let r1 = &mut s;
//    let r2 = &mut s;

//    println!("{}, {}", r1, r2);
  }

  { let mut s = String::from("hello");

    { let r1 = &mut s;
    }

    let r2 = &mut s;
  }

  { let reference_to_nothing = no_dangle();
    // let reference_to_nothing = dangle();
  }

  { let mut s = String::from("hello world");
    let word = first_word(&s);

    s.clear();

  //  println!("the first word is: {}", word);
  }

  { let my_string = String::from("hello world");
    let word = first_word(&my_string[..]);
    let my_string_literal = "hello world";
    let word = first_word(&my_string_literal[..]);
    let word = first_word(my_string_literal);
  }

}

fn first_word(s: &str) -> &str {
  let bytes = s.as_bytes();

  for (i,&item) in bytes.iter().enumerate() {
    if item == b' ' {
      return &s[0..i];
    }
  }
  &s[..]
}

fn no_dangle() -> String {
  let s = String::from("hello");
  s
}

//fn dangle() -> &String {
//    let s = String::from("hello");
//    &s
//}

fn change(some_string: &mut String) {
  some_string.push_str(", world");
}

fn calculate_length_ref(s: &String) -> usize {
  s.len()
}

fn calculate_length(s: String) -> (String, usize) {
  let length = s.len();
  (s,length)
}

fn gives_ownership() -> String {
  let some_string = String::from("hello");

  some_string
}

fn takes_and_gives_back(a_string: String) -> String {
  a_string
}

fn takes_ownership(some_string: String) {
  println!("{}", some_string);
}

fn makes_copy(some_integer: i32) {
  println!("{}", some_integer);
}




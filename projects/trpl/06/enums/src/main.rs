enum IpAddrKind {
  V4,
  V6,
}

struct IpAddr {
  kind : IpAddrKind,
  address: String,
}

enum IpAddr_ {
  V4(String),
  V6(String),
}

enum Message {
  Quit,
  Move { x: i32, y: i32 },
  Write(String),
  ChangeColor(i32, i32, i32),
}

impl Message {
  fn call(&self) {
    // does something
  }
}

#[allow(dead_code)]
#[allow(unused_variables)]
fn main() {

  { let home = IpAddr {
      kind: IpAddrKind::V4,
      address: String::from("127.0.0.1"),
    };

    let loopback = IpAddr {
      kind: IpAddrKind::V6,
      address: String::from("::1"),
    };
  }

  { let home_ = IpAddr_::V4(String::from("127.0.0.1"));
    let loopback_ = IpAddr_::V6(String::from("::1"));
  }

  { let m = Message::Write(String::from("hello"));
    m.call();
  }

  { let some_number = Some(5);
    let some_string = Some("a string");

    let absent_number: Option<i32> = None;
  }

}

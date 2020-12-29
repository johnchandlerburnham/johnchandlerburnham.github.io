fn main() {
  {
    let v: Vec<i32> = Vec::new();

    let v2 = vec![1, 2, 3];

    let mut v3 = Vec::new();

    v3.push(5); // type inference!
    v3.push(6);
    v3.push(7);
    v3.push(8);
    println!("v3 is {:?}", v3);
  }

  {
    let v = vec![1, 2, 3, 4, 5];
    let third: &i32 = &v[2];
    println!("The third element is {}", third);

    match v.get(2) {
      Some(third) => println!("The third element is {}", third),
      None => println!("There is no third element."),
    }

    // let sixth: &i32 = &v[6];
    // println!("The sixth element is {}", sixth);
    //
  }

  {
    let mut v = vec![1, 2, 3, 4, 5];
    println!("v is {:?}", v);

    let first = v[0];

    println!("first is {}", first);
    v[0] = 3;
    let first = &v[0];
    let first_ = first;
    // let v2 = v.clone();

    println!("first is {}", first_);

    v.push(6);
    let first2 = &v[0];
    println!("first2 is {}", first2);
    println!("v is {:?}", v);
  }

  {
    let v = vec![100, 32, 57];
    for i in &v {
      println!("{}", i);
    }
  }

  {
    let mut v = vec![100, 32, 57];
    println!("v is {:?}", v);

    for i in &mut v {
      *i += 50;
    }

    println!("v is {:?}", v);
  }

  {
    enum SpreadsheetCell {
      Int(i32),
      Float(f64),
      Text(String),
    }

    let row = vec![
      SpreadsheetCell::Int(3),
      SpreadsheetCell::Text(String::from("blue")),
      SpreadsheetCell::Float(10.12),
    ];
  }
}

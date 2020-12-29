use std::collections::HashMap;
extern crate unicode_segmentation;
use std::io;

use unicode_segmentation::UnicodeSegmentation;

fn main() {
  {
    let mut scores = HashMap::new();

    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);
  }

  {
    let teams = vec![String::from("Blue"), String::from("Yellow")];
    let initial_scores = vec![10, 50];

    let scores: HashMap<_, _> =
      teams.iter().zip(initial_scores.iter()).collect();

    println!("teams: {:?}", teams);
    println!("scores: {:?}", scores);
  }

  {
    let field_name = String::from("Favorite color");
    let field_value = String::from("Blue");

    let mut map = HashMap::new();

    map.insert(field_name, field_value);
    //println!("field_name: {}", field_name);
  }
  {
    let mut scores = HashMap::new();

    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);

    let team_name = String::from("Blue");
    let score = scores.get(&team_name);
    println!("score: {:?}", score);

    for (key, value) in &scores {
      println!("{}: {}", key, value);
    }
  }

  {
    let mut scores = HashMap::new();

    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Blue"), 25);

    println!("{:?}", scores);
  }

  {
    let mut scores = HashMap::new();

    scores.insert(String::from("Blue"), 10);

    scores.entry(String::from("Yellow")).or_insert(50);
    scores.entry(String::from("Blue")).or_insert(50);

    println!("{:?}", scores);
  }

  {
    let text = "hello world wonderful world";
    let mut map = HashMap::new();

    for word in text.split_whitespace() {
      let count = map.entry(word).or_insert(0);
      *count += 1;
    }

    println!("{:?}", map);
  }

  {
    let v = vec![1, 2, 3, 4, 5, 6, 10, 11, 11];

    println!("mean of v is: {}", mean(&v));
    println!("median of v is: {}", median(&v));
    println!("mode of v is: {:?}", mode(&v));

    println!("{} in pig-latin is {}", "foo", pig_latin("foo"));
    let hello = String::from("Dobrý den");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("Hello");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("こんにちは");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("안녕하세요");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("你好");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("Olá");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("Здравствуйте");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
    let hello = String::from("Hola");
    println!("{} in pig-latin is {}", hello, pig_latin(&hello));
  }

  {
    println!("");
    let dept = department();
    println!("the department records are {:?}", dept);
  }
}

fn median(ns: &Vec<i32>) -> f32 {
  let mut ms = ns.clone();
  ms.sort();
  let l = ns.len();
  if l % 2 == 1 {
    ms[l / 2] as f32
  } else {
    (ms[l / 2] as f32 + ms[l / 2 - 1] as f32) / 2.0
  }
}

fn mean(ns: &Vec<i32>) -> f32 {
  let total: i32 = ns.iter().sum();
  let size = ns.len() as f32;
  total as f32 / size
}

fn mode(ns: &Vec<i32>) -> Vec<i32> {
  let mut map: HashMap<i32, i32> = HashMap::new();
  for n in ns {
    let count = map.entry(*n).or_insert(0);
    *count += 1;
  }
  let max: i32 = *map.iter().max_by_key(|(_, &v)| v).unwrap().1;
  map
    .iter()
    .filter(|(_, &v)| v == max)
    .map(|(&k, _)| k)
    .collect()
}

fn pig_latin(s: &str) -> String {
  let mut g = UnicodeSegmentation::graphemes(s, true).collect::<Vec<&str>>();
  let first_g = g.remove(0);
  g.join("") + "-" + first_g + "ay"
}

fn department() -> HashMap<String, String> {
  println!(
    "Welcome to the department records interface.
    \nPlease type \"add <person> to <dept> ;\" to add a record.
    \nType \"quit\" to quit."
  );

  let mut map = HashMap::new();

  loop {
    let mut line = String::new();

    io::stdin()
      .read_line(&mut line)
      .expect("Failed to read line");

    let words: Vec<&str> = line.split(' ').collect();

    match words.as_slice() {
      ["quit\n"] => {
        println!("goodbye");
        break;
      }
      ["add", name, "to", dept, ";\n"] => {
        map.insert(name.to_string(), dept.to_string());
        println!("Added {} to {}", name, dept);
      }
      _ => {
        println!("Please enter a command");
        continue;
      }
    }
  }
  map
}

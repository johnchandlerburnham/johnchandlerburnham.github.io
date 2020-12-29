use std::{
  env,
  error::Error,
  fs,
};

pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
  let contents = fs::read_to_string(&config.filename)?;

  // println!("Searching for {}", &config.query);
  // println!("In file {}", &config.filename);

  for line in search(&config.query, config.case_sensitive, &contents) {
    println!("{}", line);
  }

  Ok(())
}

pub struct Config {
  pub query:          String,
  pub filename:       String,
  pub case_sensitive: bool,
}

impl Config {
  pub fn new(mut args: std::env::Args) -> Result<Config, &'static str> {
    if args.len() < 3 {
      return Err("not enough arguments");
    }
    args.next();
    let query = match args.next() {
      Some(arg) => arg,
      None  => return Err("Didn't get a query string"),
    };
    let filename = match args.next() {
      Some(arg) => arg,
      None  => return Err("Didn't get a filename"),
    };
    let case_sensitive = env::var("CASE_INSENSITIVE").is_err();
    Ok(Config { query, filename, case_sensitive })
  }
}

pub fn search<'a>(query: &str, case: bool, contents: &'a str) -> Vec<&'a str> {
  let query = if case { query.to_owned() } else { query.to_lowercase() };

  contents
    .lines()
    .filter(|line| 
      if case {
        return line.contains(&query[..]);
      } else {
        return line.to_lowercase().contains(&query[..]);
      })
     .collect()
}

  //for line in contents.lines() {
  //  let l: String = if case { line.to_owned() } else { line.to_lowercase() };
  //  if l.contains(&query) {
  //    results.push(line);
  //  }
  //}
  //results
//}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn one_result() {
    let query = "duct";
    let contents = "\
Rust:
safe, fast, productive.
Pick three.";

    assert_eq!(vec!["safe, fast, productive."], search(query, true, contents));
  }

  #[test]
  fn case_insensitive() {
    let query = "rUsT";
    let contents = "\
Rust:
safe, fast, productive.
Pick three.
Trust me.";

    assert_eq!(vec!["Rust:", "Trust me."], search(query, false, contents));
  }
}

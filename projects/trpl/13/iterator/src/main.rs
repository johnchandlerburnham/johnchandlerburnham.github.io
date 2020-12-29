fn main() {
  let v1: Vec<i32> = vec![1, 2, 3];

  let v1: Vec<_> = v1.iter().map(|x| x + 1)
    .collect();
  let v2: Vec<i32> = vec![1, 2, 3];

  assert_eq!(v2, vec![2, 3, 4]);
}

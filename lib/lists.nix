{ lib }:

{
  # Get the first element of a list
  # Example: head [1 2 3] => 1
  head = list: lib.head list;

  # Get all elements except the first
  # Example: tail [1 2 3] => [2 3]
  tail = list: lib.tail list;

  # Get the last element of a list
  # Example: last [1 2 3] => 3
  last = list: lib.last list;

  # Reverse a list
  # Example: reverse [1 2 3] => [3 2 1]
  reverse = list: lib.reverseList list;

  # Get length of a list
  # Example: length [1 2 3] => 3
  length = list: lib.length list;

  # Check if list is empty
  # Example: isEmpty [] => true
  isEmpty = list: lib.length list == 0;

  # Take first n elements from a list
  # Example: take 2 [1 2 3 4] => [1 2]
  take = n: list: lib.take n list;

  # Drop first n elements from a list
  # Example: drop 2 [1 2 3 4] => [3 4]
  drop = n: list: lib.drop n list;

  # Filter list by predicate function
  # Example: filter (x: x > 2) [1 2 3 4] => [3 4]
  filter = predicate: list: lib.filter predicate list;

  # Map function over list
  # Example: map (x: x * 2) [1 2 3] => [2 4 6]
  map = fn: list: lib.map fn list;

  # Fold/reduce list from left
  # Example: foldl (acc: x: acc + x) 0 [1 2 3] => 6
  foldl = fn: initial: list: lib.foldl fn initial list;

  # Fold/reduce list from right
  # Example: foldr (x: acc: acc + x) 0 [1 2 3] => 6
  foldr = fn: initial: list: lib.foldr fn initial list;

  # Flatten nested lists
  # Example: flatten [[1 2] [3 4]] => [1 2 3 4]
  flatten = list: lib.flatten list;

  # Remove duplicates from list
  # Example: unique [1 2 2 3 3 3] => [1 2 3]
  unique = list: lib.unique list;

  # Sort list using comparison function
  # Example: sort (a: b: a < b) [3 1 2] => [1 2 3]
  sort = compareFn: list: lib.sort compareFn list;

  # Partition list into two lists based on predicate
  # Example: partition (x: x > 2) [1 2 3 4] => { right = [3 4]; wrong = [1 2]; }
  partition = predicate: list: lib.partition predicate list;

  # Group list elements by a key function
  # Example: groupBy (x: if x > 2 then "big" else "small") [1 2 3 4]
  #   => { big = [3 4]; small = [1 2]; }
  groupBy = keyFn: list:
    lib.foldl (acc: elem:
      let key = keyFn elem;
      in acc // { ${key} = (acc.${key} or []) ++ [elem]; }
    ) {} list;

  # Zip two lists together
  # Example: zip [1 2 3] ["a" "b" "c"] => [{fst=1; snd="a";} {fst=2; snd="b";} {fst=3; snd="c";}]
  zip = list1: list2: lib.zipListsWith (a: b: { fst = a; snd = b; }) list1 list2;

  # Find first element matching predicate
  # Example: find (x: x > 2) [1 2 3 4] => 3
  find = predicate: list: lib.findFirst predicate null list;

  # Check if any element matches predicate
  # Example: any (x: x > 2) [1 2 3] => true
  any = predicate: list: lib.any predicate list;

  # Check if all elements match predicate
  # Example: all (x: x > 0) [1 2 3] => true
  all = predicate: list: lib.all predicate list;
}

# Example: Using list manipulation utilities from the flakes library
{ flakes-lib }:

let
  inherit (flakes-lib.lists)
    filter map foldl
    unique sort partition
    groupBy head tail last;
in
{
  # Filter list
  example1 = filter (x: x > 5) [1 3 5 7 9];  # => [7 9]

  # Map over list
  example2 = map (x: x * 2) [1 2 3];  # => [2 4 6]

  # Fold/reduce list
  example3 = foldl (acc: x: acc + x) 0 [1 2 3 4 5];  # => 15

  # Remove duplicates
  example4 = unique [1 2 2 3 3 3 4];  # => [1 2 3 4]

  # Sort list
  example5 = sort (a: b: a < b) [3 1 4 1 5 9 2 6];  # => [1 1 2 3 4 5 6 9]

  # Partition by condition
  example6 = partition (x: x % 2 == 0) [1 2 3 4 5 6];
  # => { right = [2 4 6]; wrong = [1 3 5]; }

  # Group by category
  example7 = groupBy (x: if x < 5 then "small" else "large") [1 3 5 7 9];
  # => { small = [1 3]; large = [5 7 9]; }

  # Get first, last, and tail
  example8 = {
    first = head [1 2 3];  # => 1
    rest = tail [1 2 3];   # => [2 3]
    final = last [1 2 3];  # => 3
  };
}

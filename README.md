# Advent of Code 2021, solved with Elixir

[Advent of Code](https://adventofcode.com/) is back! Last year (and the year before that), I took a stab at it using [Elixir](https://elixir-lang.org/), but only had time to solve two problems. This year I’m trying again.

I’ve used Elixir only sparingly, so hopefully a month of consistent floundering will expand my mental paradigm of what “programming” actually looks like (as Ruby, Clojure, functional programming, etc. have). So, onward to the code:

## Instructions

Assuming that Elixir is [installed](https://elixir-lang.org/install.html):

1. Solving the day’s problem:

   `elixir day-01/solution.exs`

2. Running tests:

   `elixir -r day-01/solution.exs day-01/tests.exs`

## Lessons Learned

### Day 1:

1. The [Elixir docs](https://hexdocs.pm/elixir/) are great and comprehensive and the examples are often relevant to _actual_ problems, compared to many languages. 

2. [`IO.inspect/2` works within pipelines](https://blog.appsignal.com/2021/11/30/three-ways-to-debug-code-in-elixir.html), which is very convenient for debugging. I’ll be using this trick often:

   ```elixir
   [1, 2, 3]
   |> IO.inspect(label: "before")
   |> Enum.map(&(&1 * 2))
   |> IO.inspect(label: "after")
   |> Enum.sum
   
   # before: [1, 2, 3]
   # after: [2, 4, 6]
   # 12
   ```

3. Maybe/probably I’m overusing pipelines, but their tidy syntax works for my brain, and [it’s striking](https://github.com/zacwasielewski/adventofcode-2021-elixir/commit/b3d29d08ee8e8a09232e9d73ec42b32346c20554) how effectively they reduce the need to solve one of the [two hard things in Computer Science](https://martinfowler.com/bliki/TwoHardThings.html). 🔥

### Day 2:

1. [Maps](https://hexdocs.pm/elixir/1.12/Map.html) have a nice shorthand syntax for updating existing values:

   ```elixir
   map = %{one: 1, two: 2, three: 3}
   %{map | one: "one", three: "three"}
   
   # %{one: "one", two: 2, three: "three"}
   ```

2. [Nested modules aren’t a thing](https://toranbillups.com/blog/archive/2018/10/04/nested-modules-in-elixir/), really. I mean, kind of. They do exist, and share `import`s and `alias`es, but not functions.
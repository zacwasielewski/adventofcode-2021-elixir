# Advent of Code 2021, solved with Elixir

[Advent of Code](https://adventofcode.com/) is back! Last year (and the year before that), I took a stab at it using [Elixir](https://elixir-lang.org/), but only had time to solve two problems. This year I’m trying again.

I’ve only used Elixir a few times, so I’m hoping that a month of consistent floundering with Elixir will expand my mental paradigm of what programming actually can be (like Ruby, Clojure, and functional programming). So, onward to the code:

## Instructions

Assuming that Elixir is [installed on your system](https://elixir-lang.org/install.html):

1. Solving the day’s problem:

   `elixir day-01/solve.exs`

2. Running tests:

   `elixir -r day-01/solve.exs day-01/test.exs`

## Lessons Learned

### Day 1:

The [Elixir docs](https://hexdocs.pm/elixir/) are great and comprehensive and the examples are often relevant to actual problems, compared to many languages. 

[`IO.inspect/2` works within pipelines](https://blog.appsignal.com/2021/11/30/three-ways-to-debug-code-in-elixir.html), which is very convenient for debugging. I’ll be using this trick often:

```
[1, 2, 3]
|> IO.inspect(label: "before")
|> Enum.map(&(&1 * 2))
|> IO.inspect(label: "after")
|> Enum.sum

# before: [1, 2, 3]
# after: [2, 4, 6]
# 12
```


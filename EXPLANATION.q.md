/
  This is structured like a valid q file, though the md extension is being used to get it to render nicely.
  Output is usually included after a line, sometimes a larger explanation is given.
  Tthings  to keep in mind:
  - commands & variables within comments are denoted by \`backticks\` but will show up in a monospace font
  - all evaluation occurs from right to left
  - `\` and `/` on their own line starts a multiline comment, either can be used to start but the other one
      must be used to end. These will seem to appear randomly in the markdown view, they are correcly placed
      in the raw file
  - lines indented by four spaces and outside of comments can be copied into the q interpreter
  - placing `0N!` anywhere within an expression will print it to stdout and return it unchanged
      e.g. you can get the output for the multiplication in `(x,x)#(x*x)` without affecting the actual
      expression by writing it as `(x,x)#(0N!x*x)`

\

    r:{ (x,x) # (x*x) ? 2 }

/

  `r` is a function that takes a single implicit parameter `x` and generates a grid of random 0s and
  1s of that size:

  `r 4`
    yields
```
  0 1 0 0
  0 0 1 0
  1 1 0 0
  0 0 0 0
```
  note, if arguments to a function are not explicitly named as in `{[argA,argB] argA + argB}`
  then `x`,`y`,`z` can be used for the first three arguments. more than three can be used but in
  those cases they must all be named. Additionally, `r 2` is equivalent to `r[2]` 

  (for the purpose of reproducibility we'll hardcode `M`, but it could be generated as `M:r[4]`
  for a 4x4 random grid)
\

    M: (0 1 0 0; 0 0 1 0; 1 1 0 0; 0 0 0 0)

/
  now we'll make a list of directions in which to transpose `M` since we need to move it
  once in each direction and once in each combination of directions (up, down, left, right,
  up and left, up and right, etc...
\

    T: 1 0 -1

/
  this still requires fleshing out, basically, apply a rotation by each element in `T`
  since `\:` (called each-left) is applied first, the higher order function function it returns
  iterates over its left argument first, so to get all elements from both sides we need to use both
  each-left and each-right together.
\

    T rotate/:\: M

/
```
  1 0 0 0   0 1 0 0   0 0 1 0
  0 1 0 0   0 0 1 0   0 0 0 1
  1 0 0 1   1 1 0 0   0 1 1 0
  0 0 0 0   0 0 0 0   0 0 0 0
```
  note, q does not display the results this way, it spreads matrices with more than 2 dimensions
  sideways:
```
  EXAMPLE_M: 3 3 # "abcdefghi"  ROTATED_M: t rotate/:\: EXAMPLE_M    ROTATED_M[0]    ROTATED_M[1]
  (a representative matrix)     (perform rotations, regular output)  (each row is actually a 2d matrix)
  abc                           bca efd hig    <- ROTATED_M[0]       bca             abc
  def                           abc def ghi    <- ROTATED_M[1]       efd             def
  ghi                           cab fde igh                          hig             ghi
```
  TODO: still need to examine the difference between different permutations of each {left,right}
\

    sum sum T rotate/:\: T rotate/:\: M

/
```
  1 2 2 1
  3 4 3 2
  2 3 2 2
  3 3 2 1
```
  each `sum` lowers the dimension of the matrix by 1, instead of applying two sums we can use `raze`
  to move everything down one dimension,so we can have a "list" of 2d matrices so `sum sum x` can be
  written as `sum raze x`
\

/
  for T we'll order the transform directions differently so it's easy to drop the case where no actual
  shift occurred, so instead of having a list of the initial matrix rotated "up and left", "up",
  "up and right", "left", "not rotated", "right", etc.. which would be the result from using the
  previous definition of T, we can keep the unrotated copy at the beginning and use `1 _ x` to
  drop that entry (n _ x drops the first n elements from x)
  
  for N we calculate the neighbor counts from summing across all the remaining rotations

  finally, only cells where the neighbor count is 2 or 3 will be "alive" in the next stage
  this is an example of how certain verbs "penetrate," i.e. `=` `|` and `&` only operate on
  primitives so they go "into" their arguments if their arguments aren't atoms
  
  the final statement is implicitly returned
\


    life:{
      T:0 1 -1;
      N:sum 1 _ (raze T rotate/:\: T rotate/:\: x);
      (3=N)|(2=N)&x }


    life[M]

/
```
  0 0 0 0
  1 0 1 0
  0 1 0 0
  1 1 0 0
```
  this is the result of a single application of the life function to M
\

/
  check out the actual repo ( https://github.com/tjcelaya/game-of-life ) for the final implementation
  with websockets!
\

# Project 1: Tic-tac-toe in Racket


In this project the following five functions are implemented:

- (board? lst) -- checks whether a list l is a valid board
- (next-move board) -- checks which player moves next
- (valid-move? board row col player) -- checks whether a move is valid
- (make-move board row col player) -- updates a board
- (winner? board) -- checks whether a board has a winner
- 

## Representing boards

The board is represented as a list of symbols of length n=k*k for
some k. Each row of the board is stored sequentially, so a 3*3 board
would be represented as a list of length 9, where the first three
elements represent the first three columns in the first row of the
board. Each element of a game board is one of three symbols: 'X, 'O,
or 'E (for empty).

<details>
  <summary>Click to expand graph explanation</summary>

For example, a 3*3 size initial game board:

||||
|:-|:-:|-:|
| E| E |E |
| E| E |E |
| E| E |E |

is represented in Racket as the list '(E E E E E E E E E)

If we place a X at the middle of the board:

||||
|:-|:-:|-:|
| E| E |E |
| E| X |E |
| E| E |E |

The board be represented by the list '(E E E E X E E E E)
</details>

<details>
  <summary>board?</summary>

### (board? lst) -> boolean?

This is a predicate to determine if a board is valid. A board is valid if and only if:

- Its length is a square of some integer
- It contains only the symbols 'X 'O 'E
- The number of Xs and Os differ by at most 1
- X moves first

returns either #t or #f.

</details>

<details>
  <summary>next-move</summary>

### (next-move lst)

This function accepts a board (satisfying board?) and returns either
'X or 'O based on who should make the next move. Player X makes the
first move.

For example, a board like this

||||
|:-|:-:|-:|
| E| E |E |
| E| X |E |
| E| E |E |

will be represented as '(E E E E X E E E E), once you call
`(who-move? '(E E E E X E E E E))` it returns 'O

</details>

<details>
  <summary>valid-move?</summary>

### (valid-move? lst row col player) -> boolean?
lst is a list?  
row, col are both number?  
playeer are either 'X or 'O
returns a boolean?

This function takes in a board, and returns whether it is valid for
player. If the player wants to make a move at (row, col), determine
whether it's valid.  A move is valid when:

- It is player's turn to move
- The specified position (row,col) is currently empty (holds 'E)

</details>

<details>
  <summary>make-move</summary>

### (make-move brd row col player) -> board?
brd : board?
row, col: nonnegative-integer?
player: {'X, 'O}

This function updates brd to make a move for player at position
(row,col). Assuming the move is valid and the board is
structured correctly (satisfies board?).

For example, before the move the board may look like this  

||||
|:-|:-:|-:|
| E| E |E |
| E| X |E |
| E| E |E |

Which is represented as '(E E E E X E E E E) 

In this case, (make-move '(E E E E X E E E E) 0 0 'O)  
should return, '(O E E E X E E E E) illustrated below:

||||
|:-|:-:|-:|
| O| E |E |
| E| X |E |
| E| E |E |

</details>

<details>
  <summary>winner?</summary>

### (winner? board) -> {'X, 'O, #f}
board: board?
returns either 'X, 'O, or #f

This checks whether a board has a winner and (if so) returns either 'X
or 'O as appropriate. A board has a winner when it has a row full of
'X, column full of 'X, or whose main diagonal is 'X, and mutatis
mutandi for 'O.

For example:

||||
|:-|:-:|-:|
| O| E |E |
| E| X |E |
| E| E |E |

Should return #f as there is no winner yet. But:

||||
|:-|:-:|-:|
| O| X |O |
| E| X |E |
| E| X |E |

will return 'X as the player 'X has a col with 3 connected marks.

The following:

|||||
|:-|:-:|-:|-:|
| O| E |X | E|
| E| X |O | E|
| X| X |E | E|
| E| E |E | E|

Returns #f: even though there's a length-three diagonal (of X), it
would have to be the longest diagonal.


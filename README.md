Sudoku Solver
=============

This README will be updated as the solver changes. *Updated on Oct 22, 2013*

Currently the solver assumes the following conditions:

  - puzzle is entered into solver method as a 2D-array. 
  - all integers are between (1..9)
  - blank positions are set as 0
  - entered as 2D-array
 
#####Example argument:

        puzzle = 
           [[6,0,0,1,0,8,2,0,3],
            [0,2,0,0,4,0,0,9,0],
            [8,0,3,0,0,5,4,0,0],
            [5,0,4,6,0,7,0,0,9],
            [0,3,0,0,0,0,0,5,0],
            [7,0,0,8,0,3,1,0,2],
            [0,0,1,7,0,0,9,0,6],
            [0,8,0,0,3,0,0,2,0],
            [3,0,2,9,0,4,0,0,5]]


###Techniques Implemented


See [sudoku of the day](http://www.sudokuoftheday.com/pages/techniques-overview.php) for definitions of each: 

- Single Candidate
- Single Position


###Techniques to Implement:

- naked pair
- naked triple
- naked quad
- naked quint
- x-wing

* * * 

###Ultimate Project Goal:

- Allow solver to solve all sudoku puzzles of varying difficulty.
- Implement as a Rails web app.
    
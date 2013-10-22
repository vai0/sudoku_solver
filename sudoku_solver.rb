    puzzle_medium_1 = 
      [[1,0,0,0,0,0,5,0,0],
       [0,0,5,0,0,0,3,4,1],
       [0,0,0,1,2,0,0,0,0],
       [0,6,0,0,0,2,9,5,0],
       [8,0,0,9,0,7,0,0,3],
       [0,4,9,3,0,0,0,1,0],
       [0,0,0,0,8,9,0,0,0],
       [9,5,4,0,0,0,2,0,0],
       [0,0,1,0,0,0,0,0,5]]

#create hash containing possible values for each position on the puzzle
def build_candidates(puzzle)
  candidates = {}
  (0..8).each do |row|
    (0..8).each do |col|
      candidates.merge!({"#{row},#{col}" => Array(1..9)})
    end
  end
  candidates.delete_if do |key,value|
    row, col = key.split(",").map(&:to_i)
    puzzle[row][col] != 0
  end
end

#scan row and delete values that aren't possible
def scan_row!(candidates, puzzle)
  (0..8).each do |row|
    (0..8).each do |col|
      candidates["#{row},#{col}"].delete_if{|value| puzzle[row].include?(value)} unless candidates["#{row},#{col}"] == nil
    end
  end
  candidates
end

#scan column and delete values that aren't possible
def scan_col!(candidates, puzzle)
  (0..8).each do |row|
    (0..8).each do |col|
      candidates["#{row},#{col}"].delete_if{|value| puzzle.transpose[col].include?(value)} unless candidates["#{row},#{col}"] == nil
    end
  end
  candidates
end

#scan sub-grids and delete values that aren't possible
def scan_subgrids!(candidates, puzzle)
=begin
  
      Sub-grid numbering scheme
        _ _ _ _ _ _ _ _ 
      |     |     |     |
      |  1  |  2  |  3  |
      |_ _ _|_ _ _|_ _ _|
      |     |     |     |
      |  4  |  5  |  6  |
      |_ _ _|_ _ _|_ _ _| 
      |     |     |     |
      |  7  |  8  |  9  |
      |_ _ _|_ _ _|_ _ _|

=end

  #define each subgrid
  subgrids = Array.new(9) {Array.new}

  (0..2).each do |row|
    (0..2).each{|col| subgrids[0] << puzzle[row][col]} #grid 1
    (3..5).each{|col| subgrids[1] << puzzle[row][col]} #grid 2
    (6..8).each{|col| subgrids[2] << puzzle[row][col]} #grid 3
  end

  (3..5).each do |row|
    (0..2).each{|col| subgrids[3] << puzzle[row][col]} #grid 4
    (3..5).each{|col| subgrids[4] << puzzle[row][col]} #grid 5
    (6..8).each{|col| subgrids[5] << puzzle[row][col]} #grid 6
  end

  (6..8).each do |row|
    (0..2).each{|col| subgrids[6] << puzzle[row][col]} #grid 7
    (3..5).each{|col| subgrids[7] << puzzle[row][col]} #grid 8
    (6..8).each{|col| subgrids[8] << puzzle[row][col]} #grid 9
  end

  #scan each sub-grid and delete values that aren't possible
  (0..8).each do |row|
    (0..8).each do |col|
      unless candidates["#{row},#{col}"] == nil
        if row.between?(0,2) && col.between?(0,2)       #grid 1
          candidates["#{row},#{col}"].delete_if{|value| subgrids[0].include?(value)} 
        elsif row.between?(0,2) && col.between?(3,5)    #grid 2
          candidates["#{row},#{col}"].delete_if{|value| subgrids[1].include?(value)}
        elsif row.between?(0,2) && col.between?(6,8)    #grid 3
          candidates["#{row},#{col}"].delete_if{|value| subgrids[2].include?(value)}
        elsif row.between?(3,5) && col.between?(0,2)    #grid 4
          candidates["#{row},#{col}"].delete_if{|value| subgrids[3].include?(value)}
        elsif row.between?(3,5) && col.between?(3,5)    #grid 5
          candidates["#{row},#{col}"].delete_if{|value| subgrids[4].include?(value)}
        elsif row.between?(3,5) && col.between?(6,8)    #grid 6
          candidates["#{row},#{col}"].delete_if{|value| subgrids[5].include?(value)}
        elsif row.between?(6,8) && col.between?(0,2)    #grid 7
          candidates["#{row},#{col}"].delete_if{|value| subgrids[6].include?(value)}
        elsif row.between?(6,8) && col.between?(3,5)    #grid 8
          candidates["#{row},#{col}"].delete_if{|value| subgrids[7].include?(value)}
        else                                            #grid 9
          candidates["#{row},#{col}"].delete_if{|value| subgrids[8].include?(value)}
        end
      end
    end
  end
  candidates
end

def naked_pairs(candidates, puzzle)
  candidates.
end

def fill_blanks(candidates, puzzle)
  candidates.each do |key, value|
    if value.length == 1
      row, col = key.split(",").map(&:to_i)
      puzzle[row][col] = value[0]
    end
  end
  candidates.delete_if{|key,value| value.length == 1}
  puzzle
end

def solve_sudoku(puzzle)
  candidates = build_candidates(puzzle)

  count = 0
  while puzzle.flatten.include?(0)
    scan_row!(candidates, puzzle)
    p scan_col!(candidates, puzzle)
    scan_subgrids!(candidates, puzzle)
    fill_blanks(candidates, puzzle)
    count += 1
    break if count == 1000
  end
  puzzle
end

solve_sudoku(puzzle_medium_1).each do |row|
  puts row.join(" ")
end
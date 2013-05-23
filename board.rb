require_relative 'piece'
class Board
  def initialize
    make_empty_grid
    place_pieces
  end
  
  def [](row, col)
    @grid[row][col]
  end
  
  def []=(row, col, piece)
    #the dark squares are defined by the sum of their
    #row and column indexes being odd. ex: 0,0 is light, 0,1 is dark
    #pieces can only be placed on dark squares
    if (row + col).odd?
      @grid[row][col] = piece
    else
      raise ArgumentError.new("Can't place pieces on light squares")
    end
  end
  
  def display
    @grid.each do |row|
      r = row.map do |sq|
        sq.to_s.rjust(3).ljust(6)
      end
      puts r.join("|")
      puts "-------" * 10
    end
    nil
  end
  
  # protected
  
  def make_empty_grid
    @grid = Array.new(10) { Array.new(10)}
  end
  
  def place_pieces
    #black pieces go on dark squares of first 3 rows
    (0..2).each do |row|
      (0..9).each do |col|
        if (row + col).odd?
          self[row, col] = Pawn.new(:black, [row, col])
        end
      end
    end
    
    #white pieces go on dark squares of the last 3 rows
    (7..9).each do |row|
      (0..9).each do |col|
        if (row + col).odd?
          self[row, col] = Pawn.new(:white, [row, col])
        end
      end
    end
  end
end
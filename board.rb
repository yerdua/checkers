class Board
  def initialize
    make_empty_grid
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
      r = row.map(&:to_s).join(' | ')
      puts r
    end
    nil
  end
  
  protected
  
  def make_empty_grid
    @grid = Array.new(10) { Array.new(10)}
  end
end
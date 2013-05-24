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
    #pieces can only be placed on dark squares
    if dark_square?([row, col])
      @grid[row][col] = piece
    else
      raise ArgumentError.new("Can't place pieces on light squares")
    end
  end
  
  def free_space?(location)
    dark_square?(location) && self[*location].nil?
  end
  
  def in_board?(location)
    location.all? {|coord| coord.between?(0,9)}
  end
  
  #the dark squares are defined by the sum of their
  #row and column indexes being odd. ex: 0,0 is light, 0,1 is dark
  def dark_square?(location)
    in_board?(location) && (location[0] + location[1]).odd?
  end
  
  #move to piece class
  #check top and bottom rows for pawns of the opposite color
  #than what started there. Replace these with kings
  def promote_pawns_in_row(color, row)
    @grid[row].each_index do |col|
      loc = [row, col]
      if !self[*loc].nil? && self[*loc].color == color
        self[*loc] = King.new(color, loc, self)
      end
    end
  end
  
  #move to piece class
  def promote_pawns
    promote_pawns_in_row(:white, 0)
    promote_pawns_in_row(:black, 9)
  end
  
  def active_pieces(color)
    pieces_left = []
    @grid.flatten.each do |sq|
      if !sq.nil? && sq.color == color
        pieces_left << sq
      end
    end
    pieces_left
  end
  
  def moves_possible?(color)
    active_pieces(color).any? { |piece| !piece.blocked? }
  end
  
  def winner
    if !moves_possible?(:black)
      :white
    elsif !moves_possible(:white)
      :black
    else
      nil
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
  
  def make_empty_grid
    @grid = Array.new(10) { Array.new(10)}
  end
  
  def place_pieces
    start_positions = {
      :black => (0..2),
      :white => (7..9)
    }
    
    start_positions.each do |color, rows|
      rows.each do |row|
        (0..9).each do |col|
          loc = [row, col]
          self[*loc] = Piece.new(color, loc, self) if dark_square?(loc)
        end
      end
    end
  end
end
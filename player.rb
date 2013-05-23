class HumanPlayer
  attr_reader :name, :board
  
  def initialize(name, board)
    @name = name
    @board = board
  end
  
  def select_piece
    puts "Enter the piece coordinates in this format: 'row,column'"
    piece_coords = gets.chomp.split(',')
    piece_coords.map!(&:to_i)  
  end
  
  def select_move_type
    puts "(J)ump or (N)ormal move?"
    gets.chomp.upcase
  end
  
  def select_direction
    puts "Which direction? options: 'up_left, up_right, down_left, down_right'"
    gets.chomp
  end
  
  def get_move
    piece_coords = select_piece
    move_type = select_move_type
    direction = select_direction
    
    { :piece_coords => piece_coords,
      :move_type => move_type,
      :direction => direction }
  end

end
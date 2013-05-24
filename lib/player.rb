class HumanPlayer
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def select_piece
    puts "Enter the piece coordinates in this format: 'row,column'"
    piece_coords = gets.chomp.split(',')
    piece_coords.map!(&:to_i)  
  end
  
  def select_directions
    puts "Which direction? options: 'up_left, up_right, down_left, down_right'"
    puts "If doing multiple jumps, include all the directions in order"
    puts "If any of the jumps are invalid, the jumps will stop"
    gets.chomp.split(',').map(&:strip)
  end
  
  def get_move
    piece_coords = select_piece
    directions = select_directions
    
    { :piece_coords => piece_coords,
      :directions => directions }
  end

end
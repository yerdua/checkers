require './board.rb'
require './piece.rb'
require './player.rb'
require './exceptions.rb'

class Checkers

  def initialize(player1, player2)
    @players = {
      :white => player1,
      :black => player2
    }
    @board = Board.new
    @turn = :white
  end
  
  def play
    while (@board.moves_possible?(@turn))
      current_player = @players[@turn]
      begin
        @board.display
        puts "#{current_player.name} (#{@turn}), it's your turn."
        
        move = current_player.get_move
        piece_coords = move[:piece_coords]
        directions = move[:directions]
        
        piece = @board[*piece_coords]
        if piece.nil?
          raise InvalidMoveError.new("There's no piece at this location")
        end
        
        unless piece.color == @turn
          raise InvalidMoveError.new("can't move opponent's piece")
        end
        
        #only check the first listed direction, in case it becomes a king
        unless piece.valid_direction?(directions.first)
          raise InvalidMoveError.new("invalid direction for this piece")
        end
        
        # directions.map!(&:to_sym)
        
        piece.move(directions)
      rescue InvalidMoveError => err
        puts "Invalid move: #{err.message}\nTry again"
        retry
      end
      @turn = (@turn == :white) ? :black : :white
    end
    winner = @board.winner
    puts "The winner is #{players[winner]}!"
  end

end
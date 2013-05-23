require_relative 'board'
require_relative 'piece'

def Checkers

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
        
      rescue InvalidMoveError
        puts "Invalid move. Try again"
        retry
      end
      @turn = (@turn == :white) ? :black : :white
    end
  end

end
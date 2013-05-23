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
    until @board.over?
      current_player = @players[@turn]
      begin
        move = player.turn
        board.move_piece(move)
      rescue
        puts "Invalid move"
        retry
      end
      @turn = (@turn == :white) ? :black : :white
    end
  end

end
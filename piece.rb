# -*- coding: utf-8 -*-

class Piece
  attr_accessor :location
  def initialize(color, location, board)
    @color = color
  end
  
  def inspect
    @color
  end
  
  def move(destination)
    unless (destination[0] + destination[1]).odd?
      raise ArgumentError.new("C")
    end
  end

end

class Pawn < Piece
  SYMBOLS = {
    :white => '⚪',
    :black => '⚫'
  }
  
  def to_s
    SYMBOLS[@color]
  end
end

class King < Piece
  SYMBOLS = {
    :white => '⚪K',
    :black => '⚫K'
  }
  
  def to_s
    SYMBOLS[@color]
  end
end
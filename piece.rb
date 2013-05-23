# -*- coding: utf-8 -*-

class Piece
  attr_accessor :location
  def initialize(color, location)
    @color = color
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
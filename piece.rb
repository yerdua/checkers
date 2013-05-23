# -*- coding: utf-8 -*-

class Piece
  SYMBOLS = {
    :white => '⚪',
    :black => '⚫'
  }
  
  def initialize(color)
    @color = color
  end
  
  def to_s
    SYMBOLS[@color]
  end
end
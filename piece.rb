# -*- coding: utf-8 -*-

class Piece
  DELTAS = {
    :up_right => [-1, 1],
    :up_left => [-1, -1],
    :down_right => [1, 1],
    :down_left => [1, -1]
  }
  
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
  
  attr_reader @directions
  
  def initialize(color, location, board)
    super(color, location, board)
    case color
    when :white
      @directions = Set.new [:up_left, :up_right]
    when :black
      @directions = Set.new [:down_left, :down_right]
    end
  end
  
  def to_s
    SYMBOLS[@color]
  end
end

class King < Piece
  SYMBOLS = {
    :white => '⚪K',
    :black => '⚫K'
  }
  
  def initialize(color, location, board)
    super(color, location, board)
    @directions = Set.new [:up_left, :up_right, :down_left, :down_right]
  end
  
  def to_s
    SYMBOLS[@color]
  end
end
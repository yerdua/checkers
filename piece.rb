# -*- coding: utf-8 -*-
require 'set'
require 'debugger'
require_relative 'exceptions'

class Piece
  DELTAS = {
    :up_right => [-1, 1],
    :up_left => [-1, -1],
    :down_right => [1, 1],
    :down_left => [1, -1]
  }
  
  attr_accessor :location
  attr_reader :color
  
  def initialize(color, location, board)
    @color = color
    @location = location
    @board = board
  end
  
  def inspect
    @color
  end
  
  def blocked?
    @directions.none? {|dir| can_move?(dir) || can_jump?(dir)}
  end
  
  def jump(direction)
    jump_space_coords = add_offset(@location, direction)
    jump_space = @board[*jump_space_coords]
    destination = add_offset(jump_space_coords, direction)
    
    if can_jump?(direction)
      @board[*@location] = nil
      @board[*jump_space_coords] = nil
      @board[*destination] = self
      @location = destination
    else
      raise InvalidMoveError.new("Can't jump #{direction} to #{destination}")
    end
  end
  
  def can_jump?(direction)
    jump_space_coords = add_offset(@location, direction)
    jump_space = @board[*jump_space_coords]
    destination = add_offset(jump_space_coords, direction)
    
    valid_direction?(direction) && valid_destination?(destination) &&
      !jump_space.nil? && (jump_space.color == opponent)
  end
  
  def move(direction)
    destination = add_offset(@location, direction)
    
    if can_move?(direction, destination)
      @board[*@location] = nil
      @board[*destination] = self
      @location = destination
    else
      raise InvalidMoveError.new("Can't move #{direction} to #{destination}")
    end
  end
  
  def can_move?(direction)
    destination = add_offset(@location, direction)
    valid_direction?(direction) && valid_destination?(destination)
  end
  
  #move into board class
  def valid_destination?(destination)
    @board.dark_square?(destination) && @board[*destination].nil?
  end
  
  def valid_direction?(direction)
    @directions.include? direction
  end
  
  def add_offset(location, direction)
    offset = DELTAS[direction]
    [offset[0] + location[0], offset[1] + location[1]]
  end
  
  def opponent
    @color == :white ? :black : :white
  end

end

class Pawn < Piece
  SYMBOLS = {
    :white => '⚪',
    :black => '⚫'
  }
  
  attr_reader :directions
  
  def initialize(color, location, board)
    super(color, location, board)
    case color
      #change sets to arrays, since they are short.
      #also, make this a terery
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
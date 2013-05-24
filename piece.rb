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
  
  SYMBOLS = {
    :white => '⚪',
    :black => '⚫'
  }
  
  attr_accessor :location
  attr_reader :color, :king
  alias_method :king?, :king
  
  def initialize(color, location, board)
    @color = color
    @king = false
    @location = location
    @board = board
  end
  
  def to_s
    "#{SYMBOLS[@color]}#{king ? ' K' : ''}"
  end
  
  def inspect
    @color
  end
  
  def blocked?
    directions.none? {|dir| can_slide?(dir) || can_jump?(dir)}
  end
  
  def move(directions)
    jumped = false
    
    dir = directions.shift
    if can_jump?(dir)
      jump(dir)
      jumped = true
    elsif can_slide?(dir)
      slide(dir)
    else
      raise InvalidMoveError.new("Can't jump or slide to #{direction}")
    end
    
    if directions.count > 0 && jumped
      do_extra_jumps(directions)
    else
    end
    
    @king = true if reached_other_side?
  end
  
  def can_jump?(direction)
    jump_space_coords = add_offset(@location, direction)
    jump_space = @board[*jump_space_coords]
    destination = add_offset(jump_space_coords, direction)
    
    valid_direction?(direction) && @board.free_space?(destination) &&
      !jump_space.nil? && (jump_space.color == opponent)
  end
  
  def can_slide?(direction)
    destination = add_offset(@location, direction)
    valid_direction?(direction) && @board.free_space?(destination)
  end
  
  def valid_direction?(direction)
    if direction.is_a?(String) #avoid converting user input to symbol
      directions.map(&:to_s).include? direction
    else
      directions.include? direction
    end
  end
  
  private
  
    def do_extra_jumps(directions)
      until directions.empty?
        begin
          dir = directions.shift
          jump(dir) if can_jump?(dir)
          @king = true if reached_other_side?
        rescue InvalidMoveError
          puts "multiple jumps failed"
        end
      end
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
  
    def slide(direction)
      destination = add_offset(@location, direction)
    
      if can_slide?(direction)
        @board[*@location] = nil
        @board[*destination] = self
        @location = destination
      else
        raise InvalidMoveError.new("Can't move #{direction} to #{destination}")
      end
    end
  
    def add_offset(location, direction)
      offset = DELTAS[direction]
      [offset[0] + location[0], offset[1] + location[1]]
    end
  
    def opponent
      @color == :white ? :black : :white
    end
  
    def directions
      if king?
        [:up_left, :up_right, :down_left, :down_right]
      else
        @color == :white ? [:up_left, :up_right] : [:down_left, :down_right]
      end
    end
  
    def reached_other_side?
      @color == :white ? @location[0] == 0 : @location[0] == 9
    end

end
require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    self.children
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
      result = []
      new_board = board.dup
      (0..2).each do |x|
        (0..2).each do |y|
          if new_board[[x,y]].nil?
            result << TicTacToeNode.new(new_board, :o, [x,y])
            new_board[[x,y]] = result.last
          end
        end
      end
      result
  end
end

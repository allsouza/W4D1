require_relative "./00_tree_node.rb"
require "byebug"

class KnightPathFinder

    def self.valid_moves(pos) #use class constant
        moves = []
        x = pos[0]
        y = pos[1]
        
        moves << [x+2, y+1] if x+2 < 8 && y+1 < 8
        moves << [x+2, y-1] if x+2 < 8 && y-1 >= 0
        moves << [x+1, y-2] if x+1 < 8 && y-2 >= 0
        moves << [x-1, y-2] if x-1 >= 0 && y-2 >= 0
        moves << [x-2, y-1] if x-2 >= 0 && y-1 >= 0
        moves << [x-2, y+1] if x-2 >= 0 && y+1 < 8
        moves << [x-1, y+2] if x-1 >= 0 && y+2 < 8
        moves << [x+1, y+2] if x+1 < 8 && y+2 < 8

        moves
    end

    def initialize(start)
        @root_node = PolyTreeNode.new(start)
        @considered_pos = []
    end


    attr_reader :root_node

    def new_move_positions(pos) #refactor
        possible = KnightPathFinder.valid_moves(pos)
        possible.reject! { |pos| @considered_pos.include?(pos) }
        @considered_pos += possible
        possible
    end

    def build_move_tree
        queue = [root_node]
        until queue.empty?
            current = queue.shift
            possibilities = new_move_positions(current.value)
            possibilities.each do |next_node|
                new_node = PolyTreeNode.new(next_node)
                queue << new_node
                current.add_child(new_node)
            end
        end
    end

    def find_path(end_pos)
        final = root_node.bfs(end_pos)
        trace_back(final, root_node)
    end

    def trace_back(end_node, start_node)
        result = [end_node]
        until result.include?(start_node)
            result << (result.last).parent
        end
        result.reverse.map { |node| node.value }
    end
end

if __FILE__ == $PROGRAM_NAME
    test = KnightPathFinder.new([0,0])

    p test.build_move_tree
    # debugger
    p test.find_path([5,4])
    p test.find_path([7, 6])
    p test.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
    
end
require "byebug"
class PolyTreeNode
   
    def initialize(value, parent = nil)
        @parent = parent
        @children = []
        @value = value
    end

    attr_accessor :value , :parent , :children 

    def inspect
        parent_value = @parent ? @parent.value : "no parent"
        { 'value' => @value, 'parent_value' => parent_value}.inspect
    end

    def parent=(grand_parent)
        if grand_parent != nil && @parent != grand_parent
            old_parent = @parent
            if !(grand_parent.children).include?(self) 
                @parent = grand_parent
                grand_parent.add_child(self) 
                grand_parent.children << self 
            end  
            (old_parent.children).delete(self) if old_parent != nil
        end        
         @parent = nil if grand_parent == nil
    end

    def add_child(node) 
       node.parent = self
    end

    def remove_child(node)
        if node.parent == nil
            raise "this is an orphan"
        end  
        node.parent = nil
    end
    
   

    def dfs(target)
        result = nil
        result = self if self.value == target
        if result.nil? && !self.children.empty?
            self.children.each do |child|
                result = child.dfs(target)
                return result if !result.nil?
            end
        end
        result
    end

    def bfs(target) 
        queue = [self]
        while !queue.empty?
            current = queue.shift
            return current if current.value == target
            current.children.each { |child| queue << child }
        end
        nil
    end
end


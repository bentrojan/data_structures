#from http://zvkemp.github.io/blog/2014/04/25/binary-search-trees-in-ruby/
#it doesn't work.

module BinaryTree

	class EmptyNode

		def include?(*)
			false
		end

		def insert(*)
			false
		end

		def inspect
			"{}"
		end

		def to_a
			[]
		end

	end


	class Node
		attr_accessor :left, :right
		attr_reader :value

		def initialize(value)		
			@value = value
			@left = EmptyNode.new
			@right = EmptyNode.new
		end

		def inspect
			"{#{value}::#{left.inspect}|#{right.inspect}}"
		end

		def insert(v)
			case value <=> v
			when 1 then insert_left(v)
			when -1 then insert_right(v)
			when 0 then false
			end
		end

		def include?(v)
			case @value <=> v
			when 1 then @left.include?(v)
			when -1 then @right.include?(v)
			when 0 then true
			end
		end

		def to_a
			left.to_a + [@value] + right.to_a
		end

		private

		def insert_left(v)
			@left.insert(v) or self.left = Node.new(v)
			puts self.inspect
		end

		def insert_right(v)
			@right.insert(v) or self.right = Node.new(v)
			puts self.inspect
		end

	end

	
end

#same as "self.from_array" in the tutorial
def build_tree(array)
	root = BinaryTree::Node.new(array[0])
	array.each_index do |i|
		root.insert(array[i]) unless i==0
	end
	root
	
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = build_tree(array)

puts tree.to_a.inspect




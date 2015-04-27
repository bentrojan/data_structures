class Node
	include Enumerable

	attr_accessor :value, :left, :right, :parent
	def initialize(v, l = nil, r = nil, p = nil)
		@value = v
		@left = l
		@right = r
		@parent = p
	end

	def each(&block)
		left.each(&block) if left
		block.call(self)
		right.each(&block) if right
	end

	def <=>(other_node)
		value <=> other_node.value
	end

end


class Tree

	attr_reader :root, :tree
	def initialize(array)
		@root = Node.new(array.shift)
		@tree = [@root]
		build_tree(array)	
	end

	def build_tree(array)
		array.each { |x| @tree << insert(Node.new(x), @root) }
	end

	def insert(node, parent)
		node.parent = parent
		if node.value > parent.value
			parent.right.nil? ? parent.right = node : insert(node, parent.right)
		else 
			parent.left.nil? ? parent.left = node : insert(node, parent.left)
		end
	end

	def to_a(node = @root)
		a = []
		a << to_a(node.left) unless node.left.nil?
		a << node.value
		a << to_a(node.right) unless node.right.nil?
		a.flatten
	end

	def bfs(target)
		queue = [@root]
		
		until queue.empty?
			node = queue.shift

			if node.value == target
				return "FOUND IN NODE: #{node.inspect}"
			else
				queue << node.left unless node.left.nil?
				queue << node.right unless node.right.nil?
			end
		end
		nil
	end


	def dfs(target)
		stack = [@root]
		visited = [@root]

		until stack.empty?
			puts "\n\n#{stack.each {|x| print "#{x.value} - "}}"
			node = stack.pop
			visited << node
			
			if node.value == target
				return "FOUND IN NODE: #{node.inspect}"
			else				
				stack << node.left unless node.left.nil? || visited.include?(node.left)
				stack << node.right unless node.right.nil? || visited.include?(node.right)
			end
		end
		nil
	end

	def dfs_rec(target, node = @root)
		return "VICTORY AT #{node}" if target == node.value
		puts "\t #{node.value}"

		left_stack = dfs_rec(target, node.left) unless node.left.nil?
		return left_stack if left_stack
		right_stack = dfs_rec(target, node.right) unless node.right.nil?
		return right_stack if right_stack
		nil
	end

end






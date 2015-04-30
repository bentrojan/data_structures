class Box
	attr_reader :x, :y, :value

	def initialize(value)
		@x = value[0]
		@y = value[1]
		@value = [@x,@y]
	end


	def legal?
		(0..7) === @x && (0..7) === @y
	end

	def move?(o)
		dx = (@x - o.x).abs
		dy = (@y - o.y).abs
		legal? && o.legal? && (dx == 1 && dy == 2 || dx == 2 && dy == 1)
	end

end


class Board
	attr_reader :root, :board


	def initialize()
		@board = []
		build_board
		@moves = []
	end

	def build_board
		(0..7).each do |x|
			(0..7).each do |y|
				@board << Box.new([x,y])
			end
		end		
	end

	def knight_moves(from, to)

		start = @board.find { |f| f.value == from }
		finish = @board.find { |f| f.value == to }

		@moves << [Box.new(from)]
		@board.delete_if { |f| f == start }
		i = 0

		until @moves[i].empty? || @moves[i].include?(finish) do
			i += 1
			@moves[i] = @moves[i-1].inject([]) do |memo, obj|
				memo.concat(@board.find_all { |b| b.move?(obj) })
			end

			@board.delete_if { |b| @moves[i].include?(b) }
		end

		if @moves[i].include?(finish)
			final = [finish]

			until i == 0
				i -= 1

				jumps = @moves[i].find_all { |b| b.move?(final.first)}
				final[0,0] = jumps.sort_by { rand }.first
			end
		end

		puts ""
		final.each {|f| print "-#{f.value.to_s}-"}
		puts ""
	end
end
	

Board.new.knight_moves([0,0],[7,7])	
Board.new.knight_moves([3,3],[4,3])
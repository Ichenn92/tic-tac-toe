class Game
	attr_accessor

	def initialize ()
		@LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		@board = Array.new(10)
		@player = [Player.new('X'.cross),Player.new('O'.circle)]
		@current_player = 0
		puts 'Welcome to Tic-Tac-Toe, let\'s start the game'.title
	end

	def play
    loop do
      clear_screen
			puts "PLAYER #{@current_player+1}".brown.bold
			puts "Place your marker #{@player[@current_player].marker}".brown
			choose_place_marker()
			if win()
				@player[@current_player].win
				reset()
				switch_player()
				display_result()
			elsif !free_space?
				puts "***************************"
				puts "it's a DRAW"
				puts "***************************\n\n"
				reset()
				switch_player()
			else
				switch_player()
			end
		end
	end

	def display_result
		puts "***************************"
		puts "  ___  ___  ___   ___   ___".bold
		puts " /__  /    /  /  /__/  /__ ".bold
		puts "___/ /__  /__/  /  |  /__  ".bold
		puts "___________________________"
		puts "player 1 - player 2"
		puts "   [#{@player[0].round_won}]       [#{@player[1].round_won}]".bold.blue
    puts "***************************\n\n"
    sleep(2)
	end

	def free_space?
		@board[1..9].all? { |position| !position.nil? } ? false : true
	end

	def reset
		@board = Array.new(10)
	end

	def switch_player
		@current_player = 1 - @current_player
	end

	def win
		return @LINES.any? { |line| line.all? { |element| @board[element] == @player[@current_player].marker }}
	end

	def choose_place_marker
		loop do
			print_board()
			print 'Choose an available position : '.cyan
			position = STDIN.getch.to_i
			puts "\n\n"
			
			if !position.between?(1,9)
        puts 'Wrong input, try again'.red
        sleep(1)
        play
			elsif @board[position].nil?
				@board[position] = @player[@current_player].marker
				return
			else
        puts 'Choose an AVAILABLE number'.red
        sleep(1)
        play
			end
		end
	end

	def print_board
		lines = [[7,8,9],[4,5,6],[1,2,3]]
		row_separation, line_separation = ' | ', '--+---+--'
		
		label_position = -> (position) { @board[position] ? @board[position] : position } 
		lines.each do |line|
			line.map!{ |element| label_position.call(element) }
		end
		
		display_line = -> (line) { line.join(row_separation) }
		display_lines = -> (lines) { lines.map { |line| display_line.call(line)}.join("\n" + line_separation + "\n") }
		puts display_lines.call(lines)
	end
end
class Player
	attr_accessor :marker, :round_won

	def initialize (marker)
		# @game = game
		@marker = marker
		@round_won = 0
	end

	def win
		@round_won += 1
	end

end
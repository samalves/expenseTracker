require "./scanner.rb"

# Simple representation of a token
class Token

	def initialize type, value
		@type = type
		@value = value
	end

	def to_s
		"#{@type}: #{@value}"
	end

end

# The starting point, thus far.
# 
# Call this class' tokenize method to
# receive an array of token objects.
#
# TODO: Add cases for the other tokens
class Tokenizer

	def initialize filename
		@filename = filename
		@scanner
		@buffer = []
		@tokens = []
		@mark # used to mark the start of a token
	end

	def tokens
		@tokens
	end

	def tokenize
		@scanner = Scanner.new @filename

		while @scanner.char
			
			# Add more cases.
			case @scanner.char
			when /"/
				@mark = @scanner.position
				@scanner.next # throw away the quote
				description
			else
				@scanner.next
			end
		end

		tokens
	end

	def description
	
		while @scanner.char != "\""

			# scanner.char will only be nil when there's a mising
			# end quote. 
			if @scanner.char.nil?
				puts "Error on line #{@mark[0] + 1}: Missing an ending quote"
				puts File.new(@filename).readlines[@mark[0]]
				count = line.each_char.find_index {|c| c.match /[0-9]/ }
				(count - 1).times { print " "}
				puts "^"
				exit -1
			end

			@buffer << @scanner.char
			@scanner.next
		end

		@scanner.next # throw away the ending quote

		unless @buffer.empty?
			@tokens << Token.new(:description, @buffer.join.strip)
			@buffer.clear
		end
	end

end


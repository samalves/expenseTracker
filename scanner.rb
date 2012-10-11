# Simple scanner that iterate through all the characters
# in the given source code.
#
# Use the class' char method to get the initial character
# of source code. 
#
# Uset the next method to the next character.
#
class Scanner

	# Initializes scanner to the first character
	# in the source code.
	def initialize filename
		@source = File.new(filename).readlines.map do |line|
			line.split //
		end
		@line = 0
		@column = 0
		@char = @source[@line][@column]
	end

	# return next character. 
	# If eof, then return nil.
	def next

		return nil if @line == @source.length

		@column += 1

		if @column == @source[@line].length
			@column = 0
			@line += 1
			if @line == @source.length
				@char = nil
				return nil
			end
		end

		@char = @source[@line][@column]
	end

   # Return the current line number
	def line
		@line
	end

   # Return the current column number
	def column
		@column
	end

   # Return an array containing both the
   # line number and the column number.
	def position
		[@line, @column]
	end

   # Return recently consumed character.
   # Call the next method to the character after
   # this one.
	def char
		@char
	end

end

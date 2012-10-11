
File.open("sample.out.log", "r") do |f|

	state = :start
	buffer = ""

	while char = f.getc
		case state
		when :start
			if char =~ /\d/
				buffer << char
				state = :number
			elsif char =~ /"/
				state = :description
			elsif char =~ /@/
				state = :recipient
			elsif char =~ /\[/
				state = :taglist
			elsif char =~ />/
				state = :calculation
			elsif char =~ /t/
				state = :tax
			elsif char =~ /\*/
				puts "STAR: *"
			elsif char =~ /-/
				puts "DASH: -"
			elsif char =~ /\./
				puts "POINT: ."
			end
		when :number
			if char =~ /\d/
				buffer << char
			else
				f.ungetc(char)
				puts "NUMBER:  #{buffer.strip}"
				buffer.clear
				state = :start
			end
		when :description
			if char =~ /"/
				puts "DESCRIPTION: #{buffer.strip}"
				buffer.clear
				state = :start
			else
				buffer << char	
			end
		when :recipient
			if char =~ /\n/
				f.ungetc(char)
				puts "RECIPIENT: #{buffer.strip}"
				buffer.clear
				state = :start
			else
				buffer << char
			end
		when :taglist
			if char =~ /\]/
				puts "TAGLIST: #{buffer.strip}"
				buffer.clear
				state = :start
			else
				buffer << char
			end
		when :calculation
			if char =~ /</
				puts "CALCULATION: #{buffer.strip}"
				buffer.clear
				state = :start
			else
				buffer << char
			end
		when :tax
			if char =~ /a/ and f.getc =~ /x/ and f.getc =~ /:/
				puts "Tax: tax"
				state = :start
			else
				puts "Error"
				puts "The next character would have been: #{f.getc}"
				exit
			end
		end
	end
end

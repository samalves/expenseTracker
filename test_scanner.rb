require './scanner.rb'

=begin

Print to stdout each character in the file along with line number and column number

=end

filename = "test_sample_for_scanner.txt"
s = Scanner.new filename
while s.char != nil
	puts "line #{s.line}, column #{s.column}: #{s.char}"
	s.next
end

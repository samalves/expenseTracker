require './tokenizer.rb'

=begin

Print to the stdout each token found.

=end

filename = "sample.out.log"

t = Tokenizer.new filename
puts t.tokenize 

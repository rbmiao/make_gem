class Hola_dan
	def self.hi(language = "english")
		translator = Translator.new(language)
		# puts "Hello Daniel Miao"
		translator.hello_miao
	end
end

require 'hola_dan/translator'

# class Hola_dan::Translator
# 	def initialize(language)
# 		@language = language
# 	end

# 	def hello_miao
# 		case @language
# 		when "spanish"
# 			"hola_dan mundo"
# 		else
# 			"Hello Daniel Miao"
# 		end
# 	end
# end
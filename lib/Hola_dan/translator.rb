class Hola_dan::Translator
	def initialize(language)
		@language = language
	end

	def hello_miao
		case @language
		when "spanish"
			"hola_dan mundo"
		else
			"Hello Daniel Miao"
		end
	end
end
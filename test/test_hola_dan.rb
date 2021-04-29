require 'minitest/autorun'
require 'hola_dan'

class HolaDanTest < Minitest::Test
	def test_english_hello
		assert_equal "Hello Daniel Miao", Hola_dan.hi("english")
	end

	def test_any_hello
		assert_equal "Hello Daniel Miao", Hola_dan.hi("ruby")
	end

	def test_spanish_hello
		assert_equal "hola_dan mundo", Hola_dan.hi("spanish")
	end

end

## curl -u fasten https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials; chmod 0600 ~/.gem/credentials
## curl -s http://jsonip.com/ | prettify_json.rb
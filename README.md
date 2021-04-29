# RubyGems

## These steps are following this tutorial:
```
https://guides.rubygems.org/make-your-own-gem/
```


## My first GEM
Create an empty directory, and two files/folder:
```
mkdir hola_dan
cd hola_dan
mkdir lib
touch hola_dan.gemspec
touch lib/hola_dan.rb
```

Open the folder in Sublime editor, add following to lib/hola_dan.rb
```
class Hola
  def self.hi
    puts "Hello Daniel Miao!"
  end
end
``` 
Add following to hola_dan.gemspec
```
Gem::Specification.new do |s|
  s.name        = 'hola_dan'
  s.version     = '0.0.0'
  s.summary     = "Hola! Daniel"
  s.description = "A simple hello world gem"
  s.authors     = ["Daniel Miao"]
  s.email       = 'rbmiao@gmail.com'
  s.files       = ["lib/hola_dan.rb", "lib/hola_dan/translator.rb"]
  s.homepage    = 'https://rubygems.org/gems/hola_dan'
  s.license     = 'MIT'
end
```
## Then build a gem by running:
```
rongbing$ gem build hola_dan.gemspec
  Successfully built RubyGem
  Name: hola_dan
  Version: 0.0.0
  File: hola_dan-0.0.0.gem
```


## Install it to local
```
rongbing$ gem install ./hola_dan-0.0.0.gem
Successfully installed hola_dan-0.0.0
Parsing documentation for hola_dan-0.0.0
Installing ri documentation for hola_dan-0.0.0
Done installing documentation for hola_dan after 0 seconds
1 gem installed
```

## get it in local
``` 
get list | grep hola_dan
```


## Smoke test:

```
rongbing$ irb
2.7.2 :001 > require 'hola_dan'
 => true
2.7.2 :002 > Hola_dan.hi
Hello Daniel Miao
 => nil
2.7.2 :003 >

```

## Share it on RubyGem web: fasten is my username
``` 
rongbing$ curl -u fasten https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials; chmod 0600 ~/.gem/credentials
Enter host password for user 'fasten':
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    94    0    94    0     0    126      0 --:--:-- --:--:-- --:--:--   126
```

## Push to RubyGem web
```
$ gem push hola_dan-0.0.0.gem

Pushing gem to https://rubygems.org...
Successfully registered gem: hola_dan (0.0.0)
```


## Check whether it is available
```
$ gem list -r hola_dan

*** REMOTE GEMS ***

hola_dan (0.0.0)
hola_dancb (0.0.1)
...
```

## Install gem to local
```
$ gem install hola_dan
Successfully installed hola_dan-0.0.0
Parsing documentation for hola_dan-0.0.0
Done installing documentation for hola_dan after 0 seconds
1 gem installed
```


# Requiring more files:
Edit lib/hola_dan.rb, like following:
```
class Hola_dan
  def self.hi(language = "english")
    translator = Translator.new(language)
    translator.hi
  end
end

class Hola_dan::Translator
  def initialize(language)
    @language = language
  end

  def hi
    case @language
    when "spanish"
      "hola mundo"
    else
      "hello world"
    end
  end
end
```

Or move some with an extra ruby file:
```
% tree
.
├── hola_dan.gemspec
└── lib
    ├── hola_dan
    │   └── translator.rb
    └── hola_dan.rb
```

Add lib/hola_dan/translator.rb
```
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
```

And hola_dan.rb changes to 
```
class Hola_dan
  def self.hi(language = "english")
    translator = Translator.new(language)
    # puts "Hello Daniel Miao"
    translator.hello_miao
  end
end

require 'hola_dan/translator'
```

Accordingly, hola_dan.gemspec changes to:
```
...
  s.files       = ["lib/hola_dan.rb", "lib/hola_dan/translator.rb"]
...
```

Try new gem in local, providing lib directory in case no $LOAD_PATH not setting up
```
$ irb -Ilib -rhola_dan
2.7.2 :001 >
2.7.2 :002 >
2.7.2 :003 > Hola_dan.hi("english")
 => "Hello Daniel Miao"
2.7.2 :004 >
2.7.2 :005 > Hola_dan.hi("spanish")
 => "hola_dan mundo"
2.7.2 :006 >
```

## Adding an executable:
```
% mkdir bin
% touch bin/hola_dan
% chmod a+x bin/hola_dan
```
Add following ruby script to hola_dan. All it’s doing is loading up the gem, and passing the first command line argument as the language to say hello with. 
```
#!/usr/bin/env ruby
require 'hola_dan'

puts Hola_dan.hi(ARGV[0]) 
```
Here’s an example of running it:
```
% ruby -Ilib ./bin/hola
hello world

% ruby -Ilib ./bin/hola spanish
hola mundo
```

Add executalbe file to hola_dan.gemspec
```
  ...
  s.homepage    = 'https://rubygems.org/gems/hola_dan'
  ...
```

Build it :
```
$ gem build hola_dan.gemspec
  Successfully built RubyGem
  Name: hola_dan
  Version: 0.0.1
  File: hola_dan-0.0.1.gem
```

Install new version: 
```
$ gem install hola_dan-0.0.1.gem
Successfully installed hola_dan-0.0.1
Parsing documentation for hola_dan-0.0.1
Installing ri documentation for hola_dan-0.0.1
Done installing documentation for hola_dan after 0 seconds
1 gem installed

$ gem list | grep hola
hola_dan (0.0.1, 0.0.0)
```

And test new version:
```
$ irb
2.7.2 :001 > require 'hola_dan'
 => true
2.7.2 :002 > Hola_dan.hi
 => "Hello Daniel Miao"
2.7.2 :003 >
2.7.2 :011 > Hola_dan.hi("spanish")
 => "hola_dan mundo"
2.7.2 :012 >
```

and push to Rubygem:
```
$ gem push hola_dan-0.0.1.gem
Pushing gem to https://rubygems.org...
Successfully registered gem: hola_dan (0.0.1)
```

Test them:
```
Rongbings-MacBook-Pro:hola rongbing$ ruby -Ilib ./bin/hola_dan
Hello Daniel Miao
Rongbings-MacBook-Pro:hola rongbing$
Rongbings-MacBook-Pro:hola rongbing$ ruby -Ilib ./bin/hola_dan spanish
hola_dan mundo
```

# Writing tests
Testing your gem is extremely important. Not only does it help assure you that your code works, but it helps others know that your gem does its job. When evaluating a gem, Ruby developers tend to view a solid test suite (or lack thereof) as one of the main reasons for trusting that piece of code.

Minitest is Ruby’s built-in test framework. There are lots of tutorials for using it online. There are many other test frameworks available for Ruby as well. RSpec is a popular choice. At the end of the day, it doesn’t matter what you use, just TEST!

Let’s add some tests to Hola. This requires adding a few more files, namely a Rakefile and a brand new test directory:

Create test directory
```
mkdir test
cd test
touch test_hola_dan.rb
```

Put test code:
```
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
```

And run test:
```
$ rake test
Run options: --seed 62624

# Running:

...

Finished in 0.001012s, 2964.4268 runs/s, 2964.4268 assertions/s.
3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```
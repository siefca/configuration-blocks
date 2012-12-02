Configuration blocks for classes, modules and applications
==========================================================

**configuration-blocks version `1.0`** (`True`)

* https://rubygems.org/gems/configuration-blocks
* https://github.com/siefca/configuration-blocks/tree
* pw@gnu.org


Summary
-------

This is simple module that helps in creating configuration blocks in objects.

It separates configuration blocks from a class containing configuration methods
by creating anonymous modules containing delegators. Those delegators are used
to set or get some configuration data through delegates (methods that exist in your
class or module).

Example
-------

Instance-level:

```ruby
  class SomeClass
    include ConfigurationBlocks

    def some_setting(arg)
      p "setting to #{arg}"
    end
    configuration_method :some_setting
  end

  obj = SomeClass.new
  
  obj.configuration_block do
    some_setting :some_value
  end
```

Class-level:

```ruby
  class SomeClass
    include ConfigurationBlocks

    class <<self
      def some_setting(arg)
        p "setting to #{arg}"
      end
      configuration_method :some_setting
    end
  end

  SomeClass.configuration_block do
    some_setting :some_value
  end
```

Imported from modules:

```ruby
  module MyModule
    include ConfigurationBlocks
  
    def some_setting(arg)
      p "setting to #{arg}"
    end
    configuration_method :some_setting
  end
  
  module SecondModule
    include ConfigurationBlocks
    include MyModule
  
    def other(v)
      p "setting other to #{v}"
    end
    configuration_method :other
  end
  
  class SomeClass
    include ConfigurationBlocks
    include SecondModule
  end
  
  SomeClass.new.configuration_block do
    some_setting  :some_value
    other         :other
  end
```

Note that configuration blocks called without arguments have are evaluaten within a module
that persists. You can store and retrieve instance variables, create module-level methods and so on:

```ruby
  class SomeClass
    include ConfigurationBlocks
  end

  obj = SomeClass.new
  
  obj.configuration_block do
    @some_var = 8
  end

  obj.configuration_block do
    p @some_var
  end
```

If you pass at least one argument to the configuration block, then the module will be passed as a first argument
and the context will remain as it is.

See also
--------

* See [whole documentation](http://rubydoc.info/gems/configuration-blocks/) to browse all documents.

Requirements
------------

* [rubygems](http://docs.rubygems.org/)
* [bundler](http://gembundler.com/)

Download
--------

### Source code ###

* https://github.com/siefca/configuration-blocks/tree
* `git clone git://github.com/siefca/configuration-blocks.git`

### Gem ###

* https://rubygems.org/gems/configuration-blocks

Installation
------------

```ruby
gem install configuration-blocks
```

Specs
-----

You can run RSpec examples both with

* `bundle exec rake spec` or just `bundle exec rake`
* run a test file directly, e.g. `ruby -S rspec spec/configuration-blocks_spec.rb -Ispec:lib`

Common rake tasks
-----------------

* `bundle exec rake bundler:gemfile` – regenerate the `Gemfile`
* `bundle exec rake docs` – render the documentation (output in the subdirectory directory `doc`)
* `bundle exec rake gem:spec` – builds static gemspec file (`configuration-blocks.gemspec`)
* `bundle exec rake gem` – builds package (output in the subdirectory `pkg`)
* `bundle exec rake spec` – performs spec. tests
* `bundle exec rake Manifest.txt` – regenerates the `Manifest.txt` file
* `bundle exec rake ChangeLog` – regenerates the `ChangeLog` file

Like my work?
-------------

You can send me some bitcoins if you would like to support me:

* `13wZbBjs6yQQuAb3zjfHubQSyer2cLAYzH`

Or you can endorse my skills on LinkedIn or Coderwall:

* [pl.linkedin.com/in/pwilk](http://www.linkedin.com/profile/view?id=4251568#profile-skills)

* [![endorse](http://api.coderwall.com/siefca/endorsecount.png)](http://coderwall.com/siefca)

License
-------

Copyright (c) 2012 by Paweł Wilk.

configuration-blocks is copyrighted software owned by Paweł Wilk (pw@gnu.org).
You may redistribute and/or modify this software as long as you
comply with either the terms of the LGPL (see [LGPL-LICENSE](http://rubydoc.info/gems/configuration-blocks/file/docs/LGPL-LICENSE)),
or Ruby's license (see [COPYING](http://rubydoc.info/gems/configuration-blocks/file/docs/COPYING)).

THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE.

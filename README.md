Zobi
====

Zobi helps you to orchestrate your controller behaviors using the following gems :

- [**inherited_resources**](https://github.com/josevalim/inherited_resources)
- [**has_scope**](https://github.com/plataformatec/has_scope)
- [**kaminari**](https://github.com/amatsuda/kaminari)
- [**pundit**](https://github.com/elabs/pundit)
- [**draper**](https://github.com/drapergem/draper)

How to use it?
--------------

Add it in the `Gemfile` and run `bundle install`:

```ruby
gem 'zobi'
```

Next, include Zobi module in your controller and set modules you require to include :

```ruby
extend Zobi
behaviors :inherited, :scoped, :included, :paginated, :controlled_access, :decorated
```

Available modules
-----------------

### Inherited

This module uses [inherited_resources](https://github.com/josevalim/inherited_resources) gem.


### Scoped

This module uses [has_scope](https://github.com/plataformatec/has_scope) gem.


### Included

This module only works with ActiveRecord because it uses the [Eager Loading Associations of Active Record](http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations).


### Paginated

This module uses [kaminari](https://github.com/amatsuda/kaminari) gem.


### Controlled Access

This module uses [pundit](https://github.com/elabs/pundit) and [devise](https://github.com/plataformatec/devise) gems.


### Decorated

This module uses [draper](https://github.com/drapergem/draper) gem and has a dependency on Inherited modules for now.


Developing
----------

Launch test suite :

```
cd spec/dummy
bundle exec rake db:test:prepare
cd ../..
bundle exec rspec
```

Launch the dummy app :

```
cd spec/dummy
bundle exec rake db:migrate
bundle exec rails s
```

Credits
-------

Copyright (c) 2013 af83

Released under the MIT license

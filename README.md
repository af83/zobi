Zobi
====

Zobi helps you to orchestrate your controller behaviors using the following gems :

- [**devise**](https://github.com/plataformatec/devise)
- [**inherited_resources**](https://github.com/josevalim/inherited_resources)
- [**has_scope**](https://github.com/plataformatec/has_scope)
- [**kaminari**](https://github.com/amatsuda/kaminari)
- [**pundit**](https://github.com/elabs/pundit)
- [**draper**](https://github.com/drapergem/draper)

How to use it?
--------------

Add it in your `Gemfile` and run `bundle install`:

```ruby
gem 'zobi', '~> 4.0.0.rc1'
```

Next, include Zobi module in your controller and set modules you want to
include :

```ruby
extend Zobi
behaviors :inherited, :scoped, :included, :paginated, :controlled_access, :decorated
```

Available modules
-----------------

### Inherited

This module uses
[inherited_resources](https://github.com/josevalim/inherited_resources) gem.

This module deals with String Parameters using Parameters classes.

A Parameters inherits from Zobi::ParametersSanitizer, and should define the list
of parameters and nested parameters to accept.

If your controller is namespaced, you should define the `resource_type` method to
override its generic behavior.

If your model is namespaced, you should define the defaults resource_class for
Inherited Resource, ie : `defaults resource_class: ::User::Address`

Here is an example :

``` ruby
module User
  class AddressParameters < Zobi::ParametersSanitizer

    # Optional, usefull for a namespaced controller, User::AddressesController
    # here.
    def resource_type
      :user_address
    end

    protected

    def fields
      [
        :id,
        :street,
        :zip_code,
        nested_attributes: [:id, :foo, :bar]
      ]
    end
  end
end
```

By default, Parameters class are discovered using the controller namespace.
Given a `User::AddressesController`, Zobi will search for
`User::AddressParameters` class.

If you don't want to use Parameters class, you can define the `permitted_params`
in your controller and perform custom filtering.

### Scoped

This module uses [has_scope](https://github.com/plataformatec/has_scope) gem.


### Included

This module only works with ActiveRecord because it uses the
[Eager Loading Associations of Active Record](http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations).


### Paginated

This module uses [kaminari](https://github.com/amatsuda/kaminari) gem.


### Controlled Access

This module uses [pundit](https://github.com/elabs/pundit) and
[devise](https://github.com/plataformatec/devise) gems.


### Decorated

This module uses [draper](https://github.com/drapergem/draper) gem and has a
dependency on Inherited modules for now.

By default, Zobi will try to discover the decorator class to use using the
current namespece.

For example, given a controller named Admin::User::AddressesController, Zobi
will try to find the appropriate decorator class in this order :

Collection :

``` ruby
Admin::User::AddressesDecorator
Admin::AddressesDecorator
AdressesDecorator
Admin::User::CollectionDecorator
Admin::CollectionDecorator
CollectionDecorator
```

Resource :

``` ruby
Admin::User::AddressDecorator
Admin::AddressDecorator
AdressDecorator
Admin::User::ResourceDecorator
Admin::ResourceDecorator
ResourceDecorator
```

If this is not the way you organize your decorators, you can override this
behavior by defining a method called `collection_decorator_class` or
`decorator_class` which returns the decorator class to use.


# Developing

Launch test suite :

``` console
cd spec/dummy
bundle exec rake db:test:prepare
cd ../..
bundle exec rspec
```

Launch the dummy app :

``` console
cd spec/dummy
bundle exec rake db:migrate
bundle exec rails s
```

# Versioning

We decided to follow rails versions to simplify update of Zobi when you want to
upgrade rails.

# Credits

Copyright (c) 2013 af83

Released under the MIT license

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

Add it in the `Gemfile` and run `bundle update`:

```ruby
gem 'zobi'
```

Next, include Zobi module in your controller and set modules you require to include :

```ruby
include Zobi
behaviors :inherited, :scoped, :included, :paginated, :controlled_access, :decorated
```

Credits
-------

Copyright (c) 2013 af83

Released under the MIT license

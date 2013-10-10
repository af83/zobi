# encoding: utf-8
require 'spec_helper'

describe Decorated::FoosController, type: :controller do

  before do
    20.times do
      Foo.create!(name: Faker::Name.name, published: true)
    end
  end

  it 'should decorate collection' do
    get :index
    controller.collection.should be_decorated_with Decorated::FoosDecorator
  end

  it 'should decorate resource' do
    get :show, id: Foo.first.id
    controller.resource.should be_decorated_with Decorated::FooDecorator
  end
end

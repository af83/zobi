# encoding: utf-8
require 'spec_helper'

describe Scoped::FoosController, type: :controller do

  before do
    20.times do
      Foo.create!(name: Faker::Name.name, published: true)
    end
    Foo.create!(name: 'Hello World', published: true)
  end

  it 'should filter collection' do
    get :index, by_name: 'Hello World'
    controller.collection.should have(1).items
  end
end

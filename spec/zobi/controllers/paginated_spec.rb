# encoding: utf-8
require 'spec_helper'
require 'kaminari'

describe Paginated::FoosController, type: :controller do

  before do
    20.times do
      Foo.create!(name: Faker::Name.name, published: true)
    end
  end

  it 'should limit number of items from paginate_per method' do
    get :index
    controller.collection.should have(10).items
  end

  it 'should return first page by default' do
    get :index
    controller.collection.map(&:id).should eq Foo.limit(10).map(&:id)
  end

  it 'should return requested page' do
    get :index, page: 2
    controller.collection.map(&:id).should eq Foo.limit(10).offset(10).map(&:id)
  end

  it 'should set headers' do
    get :index, page: 2
    response.headers['X-Current-Page'].should eq '2'
    response.headers['X-Limit-Value'].should eq '10'
    response.headers['X-Total-Pages'].should eq '2'
  end

end

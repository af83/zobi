# encoding: utf-8
require 'spec_helper'
require 'inherited_resources'

describe Inherited::FoosController, type: :controller do

  let!(:foo) { Foo.create!(name: 'public foo', published: true) }

  describe '#index' do
    it 'should return a collection of Foos' do
      get :index
      controller.collection.should include foo
    end
  end

  describe '#new' do
    it 'should return a new foo resource' do
      get :new
      controller.send(:resource).new_record?.should be_true
    end
  end

  describe '#edit' do
    it 'should return the requested foo resource' do
      get :edit, id: foo.id
      controller.send(:resource).should eq foo
    end
  end

  describe '#create' do
    it 'should use Parameters class to filter params' do
      Foo.should_receive(:new)
        .with({'name' => 'foo', 'category' => 'bar', 'published' => true})
        .and_return foo
      post :create, foo: {name: 'foo', category: 'bar', published: true, unknown: 'param'}
    end
  end

  describe '#update' do
    it 'should use Parameters class to filter params' do
      Foo.should_receive(:find).with(foo.id.to_s).and_return foo
      foo.should_receive(:update_attributes)
        .with({'name' => 'foo', 'category' => 'bar', 'published' => true})
        .and_return foo
      put :update, id: foo.id, foo: {name: 'foo', category: 'bar', published: true, unknown: 'param'}
    end
  end
end

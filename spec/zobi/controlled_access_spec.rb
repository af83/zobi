# encoding: utf-8
require 'spec_helper'
require 'pundit'

describe Zobi::ControlledAccess, type: :controller do

  let!(:public_foo) { Foo.create!(name: 'public foo', public: true) }
  let!(:private_foo) { Foo.create!(name: 'private foo', public: false) }

  controller do
    extend Zobi
    behaviors :controlled_access

    def new
    end

    def zobi_resource_class
      Foo
    end

    def current_user
      User.new(name: 'joker', admin: false)
    end
  end

  describe 'scope' do

    it 'should return authorized records only' do
      controller.collection.tap do |c|
        c.should include(public_foo)
        c.should_not include(private_foo)
      end
    end

  end


  describe 'permissions' do

    it "should check acl on new" do
      lambda{
        get :new
      }.should raise_error(Pundit::NotAuthorizedError)
    end

  end

end

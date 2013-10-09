# encoding: utf-8
require 'spec_helper'

class NoBehaviorController < ActionController::Base
  extend Zobi
  behaviors *[]
end

class AllBehaviorsController < ActionController::Base
  extend Zobi
  behaviors *(Zobi::BEHAVIORS - [:inherited])
end

describe Zobi do

  it 'should be a module' do
    Zobi.kind_of?(Module).should be_true
  end

  it 'should define list of available behaviors' do
    Zobi::BEHAVIORS.should eq [:inherited, :scoped, :included, :paginated,
                              :controlled_access, :decorated]
  end

  # XXX Fix require of InheritedResource::Base controller in specs.
  (Zobi::BEHAVIORS - [:inherited]).each do |behavior|
    it "should return if #{behavior} is included" do
      AllBehaviorsController.behavior_included?(behavior).should be_true
    end

    it "should know if #{behavior} is not included" do
      NoBehaviorController.behavior_included?(behavior).should be_false
    end
  end

  describe 'namespaces_from_class' do
    it 'should return namespaces of the given class' do
      Zobi.namespaces_from_class(Animals::Fishes::FugusController)
        .should eq(['::Animals::Fishes', '::Animals', '::'])
    end
  end

  describe 'classes_for_namespaces' do
    it 'should return a class per namespace' do
      Zobi.classes_for_namespaces(
        ['::Animals::Fishes', '::Animals', '::'], 'FooBar')
        .should eq(['::Animals::Fishes::FooBar', '::Animals::FooBar', '::FooBar'])
    end
  end
end

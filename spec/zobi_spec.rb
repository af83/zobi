# encoding: utf-8
require 'spec_helper'

class NoBehaviorController < ActionController::Base
  extend Zobi
  behaviors *[]
end

describe Zobi do

  it 'should be a module' do
    Zobi.kind_of?(Module).should be_true
  end

  it 'should define list of available behaviors' do
    Zobi::BEHAVIORS.should eq [:inherited, :scoped, :included, :paginated,
                              :controlled_access, :decorated]
  end

end

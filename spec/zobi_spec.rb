# encoding: utf-8
require 'spec_helper'

describe Zobi do

  it 'should define list of available behaviors' do
    Zobi::BEHAVIORS.should eq [:inherited, :scoped, :included, :paginated,
                              :controlled_access, :decorated]
  end

  context 'included in a controller' do
    subject { FakeController.new }

    describe 'should defined collection methods for each module' do
      Zobi::BEHAVIORS.each do |behavior|
        it { should respond_to :"#{behavior}_collection" }
      end
    end
  end

end

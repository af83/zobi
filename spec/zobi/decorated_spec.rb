# encoding: utf-8
require 'spec_helper'

describe Zobi::Decorated do

  describe 'collection decorator discovering' do

    let(:discovered_class) {
      Zobi::Decorated.discover_collection_decorator(
        Animals::Fishes::FugusController
      )
    }

    it 'should search for possible decorators' do
      Zobi::Decorated.collection_decorators_discovery(
        Animals::Fishes::FugusController
      ).should eq([
        "::Animals::Fishes::FugusDecorator",
        "::Animals::FugusDecorator",
        "::FugusDecorator",
        "::Animals::Fishes::CollectionDecorator",
        "::Animals::CollectionDecorator",
        "::CollectionDecorator"
      ])
    end

    context 'none of discovered decorators defined' do
      it 'should return Zobi::CollectionDecorator' do
        discovered_class.should eq Zobi::CollectionDecorator
      end
    end

    context 'root level generic decorator defined' do
      before do
        class CollectionDecorator; end
      end
      it 'should return CollectionDecorator' do
        discovered_class.should eq CollectionDecorator
      end
    end

    context 'root and first level generic decorator defined' do
      before do
        class CollectionDecorator; end
        class Animals::CollectionDecorator; end
      end
      it 'should return Animals::CollectionDecorator' do
        discovered_class.should eq Animals::CollectionDecorator
      end
    end

    context 'root, first and top level generic decorator defined' do
      before do
        class CollectionDecorator; end
        class Animals::CollectionDecorator; end
        class Animals::Fishes::CollectionDecorator; end
      end
      it 'should return Animals::Fishes::CollectionDecorator' do
        discovered_class.should eq Animals::Fishes::CollectionDecorator
      end
    end

    context 'root level decorator defined' do
      before do
        class CollectionDecorator; end
        class Animals::CollectionDecorator; end
        class Animals::FishesCollectionDecorator; end
        class FugusDecorator; end
      end
      it 'should return FugusDecorator' do
        discovered_class.should eq FugusDecorator
      end
    end

    context 'root and first level decorator defined' do
      before do
        class CollectionDecorator; end
        class Animals::CollectionDecorator; end
        class Animals::FishesCollectionDecorator; end
        class FugusDecorator; end
        class Animals::FugusDecorator; end
      end
      it 'should return Animals::FugusDecorator' do
        discovered_class.should eq Animals::FugusDecorator
      end
    end

    context 'root, first and top level decorator defined' do
      before do
        class CollectionDecorator; end
        class Animals::CollectionDecorator; end
        class Animals::FishesCollectionDecorator; end
        class FugusDecorator; end
        class Animals::FugusDecorator; end
        class Animals::Fishes::FugusDecorator; end
      end
      it 'should return Animals::Fishes::FugusDecorator' do
        discovered_class.should eq Animals::Fishes::FugusDecorator
      end
    end
  end

end

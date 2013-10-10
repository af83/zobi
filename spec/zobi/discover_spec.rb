# encoding: utf-8
require 'spec_helper'

describe Zobi::Discover do
  subject {
    described_class.new(Animals::Fishes::FugusController, :decorated, :resource)
  }

  describe 'namespaces_from_class' do
    it 'should return all namespaces of the given class' do
      subject.send(:namespaces).should eq(['::Animals::Fishes', '::Animals', '::'])
    end
  end

  context 'Decorated behavior' do
    subject {
      described_class.new(Animals::Fishes::FugusController, :decorated, type)
    }

    context 'and type resource' do
      let(:type) { :resource }

      it 'should fallback to ResourceDecorator' do
        subject.send(:fallback).should eq 'ResourceDecorator'
      end

      it 'should return Decorator suffix' do
        subject.send(:suffix).should eq 'Decorator'
      end

      it 'should discover classes' do
        subject.send(:discovery)
          .should eq([
            '::Animals::Fishes::FuguDecorator',
            '::Animals::FuguDecorator',
            '::FuguDecorator',
            '::Animals::Fishes::ResourceDecorator',
            '::Animals::ResourceDecorator',
            '::ResourceDecorator'
          ])
      end

      context 'none of discovered decorators defined' do
        it 'should return Zobi::ResourceDecorator' do
          subject.send(:resolve).should eq Zobi::ResourceDecorator
        end
      end

      context 'root level generic decorator defined' do
        before do
          class ResourceDecorator; end
        end
        it 'should resolve to ResourceDecorator' do
          subject.send(:resolve).should eq ResourceDecorator
        end
      end

      context 'root and first level generic decorator defined' do
        before do
          class ResourceDecorator; end
          class Animals::ResourceDecorator; end
        end
        it 'should resolve to Animals::ResourceDecorator' do
          subject.send(:resolve).should eq Animals::ResourceDecorator
        end
      end

      context 'root, first and top level generic decorator defined' do
        before do
          class ResourceDecorator; end
          class Animals::ResourceDecorator; end
          class Animals::Fishes::ResourceDecorator; end
        end
        it 'should resolve to Animals::Fishes::ResourceDecorator' do
          subject.send(:resolve).should eq Animals::Fishes::ResourceDecorator
        end
      end

      context 'root level decorator defined' do
        before do
          class ResourceDecorator; end
          class Animals::ResourceDecorator; end
          class Animals::FishesResourceDecorator; end
          class FuguDecorator; end
        end
        it 'should resolve to FuguDecorator' do
          subject.send(:resolve).should eq FuguDecorator
        end
      end

      context 'root and first level decorator defined' do
        before do
          class ResourceDecorator; end
          class Animals::ResourceDecorator; end
          class Animals::FishesResourceDecorator; end
          class FuguDecorator; end
          class Animals::FuguDecorator; end
        end
        it 'should resolve to Animals::FuguDecorator' do
          subject.send(:resolve).should eq Animals::FuguDecorator
        end
      end

      context 'root, first and top level decorator defined' do
        before do
          class ResourceDecorator; end
          class Animals::ResourceDecorator; end
          class Animals::FishesResourceDecorator; end
          class FuguDecorator; end
          class Animals::FuguDecorator; end
          class Animals::Fishes::FuguDecorator; end
        end
        it 'should resolve to Animals::Fishes::FuguDecorator' do
          subject.send(:resolve).should eq Animals::Fishes::FuguDecorator
        end
      end
    end

    context 'and type collection' do
      let(:type) { :collection }

      it 'should fallback to CollectionDecorator' do
        subject.send(:fallback).should eq 'CollectionDecorator'
      end

      it 'should return Decorator suffix' do
        subject.send(:suffix).should eq 'Decorator'
      end

      it 'should discover classes' do
        subject.send(:discovery)
          .should eq([
            '::Animals::Fishes::FugusDecorator',
            '::Animals::FugusDecorator',
            '::FugusDecorator',
            '::Animals::Fishes::CollectionDecorator',
            '::Animals::CollectionDecorator',
            '::CollectionDecorator'
          ])
      end

      context 'none of discovered decorators defined' do
        it 'should return Zobi::CollectionDecorator' do
          subject.send(:resolve).should eq Zobi::CollectionDecorator
        end
      end

      context 'root level generic decorator defined' do
        before do
          class CollectionDecorator; end
        end
        it 'should resolve to CollectionDecorator' do
          subject.send(:resolve).should eq CollectionDecorator
        end
      end

      context 'root and first level generic decorator defined' do
        before do
          class CollectionDecorator; end
          class Animals::CollectionDecorator; end
        end
        it 'should resolve to Animals::CollectionDecorator' do
          subject.send(:resolve).should eq Animals::CollectionDecorator
        end
      end

      context 'root, first and top level generic decorator defined' do
        before do
          class CollectionDecorator; end
          class Animals::CollectionDecorator; end
          class Animals::Fishes::CollectionDecorator; end
        end
        it 'should resolve to Animals::Fishes::CollectionDecorator' do
          subject.send(:resolve).should eq Animals::Fishes::CollectionDecorator
        end
      end

      context 'root level decorator defined' do
        before do
          class CollectionDecorator; end
          class Animals::CollectionDecorator; end
          class Animals::FishesCollectionDecorator; end
          class FugusDecorator; end
        end
        it 'should resolve to FugusDecorator' do
          subject.send(:resolve).should eq FugusDecorator
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
        it 'should resolve to Animals::FugusDecorator' do
          subject.send(:resolve).should eq Animals::FugusDecorator
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
        it 'should resolve to Animals::Fishes::FugusDecorator' do
          subject.send(:resolve).should eq Animals::Fishes::FugusDecorator
        end
      end
    end
  end
end

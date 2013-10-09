# encoding: utf-8
require 'spec_helper'
require 'pundit'
require 'devise'

describe ControlledAccess::FoosController, type: :controller do

  let!(:user) { User.create!(email: "user#{rand(1000)}@example.com", password: 'password', admin: false) }
  let!(:admin) { User.create!(email: "admin#{rand(1000)}@example.com", password: 'password', admin: true) }
  let!(:public_foo) { Foo.create!(name: 'public foo', published: true) }
  let!(:private_foo) { Foo.create!(name: 'private foo', published: false) }

  context 'user logged in' do
    before do
      sign_in user
    end

    it 'should return only public Foos' do
      get :index
      controller.collection.should include public_foo
      controller.collection.should_not include private_foo
    end

    it 'should raise Pundit::NotAuthorizedError on new' do
      expect{
        get :new
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'should raise Pundit::NotAuthorizedError on create' do
      expect{
        post :create
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'should raise Pundit::NotAuthorizedError on edit' do
      expect{
        get :edit, id: public_foo.id
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'should raise Pundit::NotAuthorizedError on update' do
      expect{
        put :update, id: public_foo.id
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'should raise Pundit::NotAuthorizedError on destroy' do
      expect{
        delete :destroy, id: public_foo.id
      }.to raise_error(Pundit::NotAuthorizedError)
    end

  end

  context 'admin logged in' do
    before do
      sign_in admin
    end
    it 'should return public and private Foos' do
      get :index
      controller.collection.should include public_foo
      controller.collection.should include private_foo
    end

    it 'should raise Pundit::NotAuthorizedError on new' do
      expect{
        get :new
      }.not_to raise_error()
    end

    it 'should raise Pundit::NotAuthorizedError on create' do
      expect{
        post :create
      }.not_to raise_error()
    end

    it 'should raise Pundit::NotAuthorizedError on edit' do
      expect{
        get :edit, id: public_foo.id
      }.not_to raise_error()
    end

    it 'should raise Pundit::NotAuthorizedError on update' do
      expect{
        put :update, id: public_foo.id
      }.not_to raise_error()
    end

    it 'should raise Pundit::NotAuthorizedError on destroy' do
      expect{
        delete :destroy, id: public_foo.id
      }.not_to raise_error()
    end
  end

end

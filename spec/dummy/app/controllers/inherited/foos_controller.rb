class Inherited::FoosController < ApplicationController
  extend Zobi
  behaviors :inherited

  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  def permitted_params
    params.permit(foo: [:name, :category, :published])
  end
end

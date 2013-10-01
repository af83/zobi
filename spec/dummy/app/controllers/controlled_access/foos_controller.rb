class ControlledAccess::FoosController < ApplicationController
  extend Zobi
  behaviors :controlled_access

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  # FIXME No acl here…
  def publish
    f = Foo.find(params[:id])
    f.update_attribute(:published, !f.published)
    redirect_to controlled_access_foos_path
  end
end

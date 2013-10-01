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
    redirect_to controlled_access_foos_path
  end

  def edit
  end

  def update
    redirect_to controlled_access_foos_path
  end

  def destroy
    redirect_to controlled_access_foos_path
  end

  # FIXME No acl here…
  def publish
    f = Foo.find(params[:id])
    f.update_attribute(:published, !f.published)
    redirect_to controlled_access_foos_path
  end
end

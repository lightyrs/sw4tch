class SwatchesController < ApplicationController

  before_filter :assign_swatch, only: [ :show, :edit, :update, :delete ]

  def index
    @swatches = Swatch.all
  end

  def show
  end

  def new
    @swatch = current_user.swatches.new
  end

  def create
    if @swatch = current_user.swatches.create(params[:swatch])
      redirect_to @swatch, notice: 'The swatch was created.'
    else
      render 'new', alert: 'There was an error creating the swatch.'
    end
  end

  def edit
  end

  def update
    if @swatch && @swatch.update_attributes(params[:swatch])
      redirect_to @swatch, notice: 'The swatch was updated.'
    else
      render 'edit', alert: 'There was an error updating the swatch.'
    end
  end

  def delete
    if @swatch && @swatch.destroy
      redirect_to :index, notice: 'The swatch was deleted.'
    else
      render 'edit', alert: 'There was an error deleting the swatch.'
    end
  end

  private

  def assign_swatch
    @swatch = current_user.swatches.find_by_id(params[:id])
  end
end

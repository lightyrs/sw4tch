class SwatchesController < ApplicationController

  before_filter :assign_user_swatch, only: [ :edit, :update, :destroy ]

  def index
    @swatches = Swatch.order('created_at DESC').limit(36)
  end

  def show
    @swatch = Swatch.find_by_id(params[:id])
  end

  def new
    @swatch = current_user.swatches.new
  end

  def create
    @swatch = current_user.swatches.build(params[:swatch])
    if @swatch.save
      redirect_to swatch_path(@swatch), notice: 'The swatch was created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @swatch.update_attributes(params[:swatch])
      redirect_to swatch_path(@swatch), notice: 'The swatch was updated.'
    else
      render :edit
    end
  end

  def destroy
    if @swatch && @swatch.destroy
      redirect_to root_path, notice: 'The swatch was deleted.'
    else
      render :edit, error: 'There was an error deleting the swatch.'
    end
  end

  private

  def assign_user_swatch
    @swatch = current_user.swatches.find_by_id(params[:id])
  end
end

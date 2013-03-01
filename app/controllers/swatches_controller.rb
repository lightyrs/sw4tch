class SwatchesController < ApplicationController

  before_filter :assign_user_swatch, only: [ :edit, :update, :destroy,
                                             :add_to_swatchbook, :remove_from_swatchbook ]

  respond_to :js, only: [:add_to_swatchbook, :remove_from_swatchbook]

  def index
    @swatches = Swatch.order('created_at DESC').paginate(page: params[:page], per_page: 36)
  end

  def show
    @swatch = Swatch.find_by_id(params[:id])
  end

  def new
    @swatch = current_user.swatches.new
  end

  def create
    if @swatch = current_user.swatches.create(params[:swatch])
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
      render :edit, alert: 'There was an error deleting the swatch.'
    end
  end

  def fork
    @swatch_to_fork = Swatch.find_by_id(params[:id])
    @forked_swatch = @swatch_to_fork.dup.tap { |s| s.user_id = current_user.id }
    if @forked_swatch.save
      redirect_to swatch_path(@forked_swatch), notice: 'The swatch was forked.'
    else
      redirect_to swatch_path(@swatch_to_fork), alert: 'There was an error forking the swatch.'
    end
  end

  def add_to_swatchbook
    @swatchbook = Swatchbook.find_by_id(params[:swatchbook_id])
    unless @swatch.swatchbooks.include? @swatchbook
      if @swatch.swatchbooks << @swatchbook && @swatch.save
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end

  def remove_from_swatchbook

  end

  def search
    @tags = params[:tags]
    Swatch.tagged_with([@tags].flatten, any: true)
  end

  def gist
    swatch = Swatch.find_by_id(params[:id])
    gist = Gist.new(
      user: swatch.user,
      swatch: swatch,
      syntax: params[:syntax],
      is_public: params[:is_public]
    )
    if @gist_url = gist.publish
      render json: @gist_url.to_json
    else
      head :not_acceptable
    end
  end

  private

  def assign_user_swatch
    @swatch = current_user.swatches.find_by_id(params[:id])
  rescue NoMethodError
    redirect_to root_path
  end
end

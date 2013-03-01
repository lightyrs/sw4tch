class SwatchbooksController < ApplicationController

  def index
    @swatchbooks = Swatchbook.order('created_at DESC').paginate(page: params[:page], per_page: 36)
  end

  def new
    @swatchbook = current_user.swatchbooks.new
  end

  def create
    if @swatchbook = current_user.swatchbooks.create(params[:swatchbook])
      redirect_to swatchbook_path(@swatchbook), notice: 'The swatchbook was created.'
    else
      render :new
    end
  end

  def edit
    @swatchbook = current_user.swatchbooks.find_by_id(params[:id])
  end

  def update
    respond_to :json do

    end

    respond_to :html do
      if @swatchbook = current_user.swatchbooks.find_by_id(params[:id])
        redirect_to swatchbook_path(@swatchbook), notice: 'The swatchbook was updated.'
      else
        render :edit
      end
    end
  end
end
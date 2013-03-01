class SwatchbooksController < ApplicationController

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
end
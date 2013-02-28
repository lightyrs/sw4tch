class HomeController < ApplicationController

  def index
    @swatches = Swatch.order('created_at DESC').paginate(page: params[:page], per_page: 36)
  end
end

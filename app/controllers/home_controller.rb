class HomeController < ApplicationController

  def index
    @swatches = Swatch.order('created_at DESC').paginate(page: params[:page], per_page: 36)
    @swatchbooks = Swatchbook.with_swatches.sort_by(&:created_at).paginate(page: params[:page], per_page: 10)
  end
end

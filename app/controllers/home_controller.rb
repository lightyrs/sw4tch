class HomeController < ApplicationController

  def index
    @swatches = Swatch.order('created_at DESC').limit(36)
  end
end

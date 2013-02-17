class HomeController < ApplicationController

  def index
    @swatches = Swatch.all
  end
end

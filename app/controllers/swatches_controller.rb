class SwatchesController < ApplicationController

  def index
    @swatches = Swatch.all
  end
end

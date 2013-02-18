class MarkupController < ApplicationController

  respond_to :json

  def compile
    @from, @to = params[:from], params[:to]
    if %w(css scss stylus).include? [@from, @to]
      respond_with Swatch.first
    else
      respond_with 'FAIL'
    end
  end
end

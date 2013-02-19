class MarkupController < ApplicationController

  respond_to :json

  def compile
    @from, @to, @markup = params[:from], params[:to], params[:markup]
    if %w(css scss stylus).include? @from and %w(css scss stylus).include? @to
      respond_with Swatch.new
    else
      head :not_acceptable
    end
  end
end

class MarkupController < ApplicationController

  respond_to :json

  before_filter :assign_vars, only: [ :compile ]

  def compile
    if %w(scss stylus).include? @from and %w(css).include? @to
      render json: Swatch.class_eval("new(#{@from}: %Q(#{@markup})).#{@from}_to_#{@to}").to_json
    else
      head :not_acceptable
    end
  end

  private

  def assign_vars
    @from, @to, @markup = params[:from], params[:to], params[:markup]
  end
end

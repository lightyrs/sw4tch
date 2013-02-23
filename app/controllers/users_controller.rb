class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id]) || current_user
    @swatches = @user.swatches
  end
end

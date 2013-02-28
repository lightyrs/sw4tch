class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id]) || current_user
    @swatches = @user.swatches.paginate(page: params[:page], per_page: 36)
  end
end

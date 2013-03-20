class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id]) || current_user
    @swatches = @user.swatches.order('created_at DESC').paginate(page: params[:page], per_page: 36)
    @swatchbooks = @user.swatchbooks.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end
end

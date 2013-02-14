class UsersController < ApplicationController

  def show
    @identity = current_user.identities.where(provider: 'github').first
  end
end

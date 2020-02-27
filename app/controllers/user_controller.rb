class UserController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user =  User.find(params[:id])
    @meals = @user.meals
  end
end

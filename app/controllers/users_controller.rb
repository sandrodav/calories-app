class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user =  User.find(params[:id])
    @meals = @user.meals
  end


  def edit
    @user =  User.find(params[:id])
  end



  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user was successfully created #{@user.name}"
      redirect_to users_path
    else
      render 'new'
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to users_path
        flash[:success] = "User acount was updated successfully"
      else
        render 'edit'
      end
  end

  def destroy
    @user =User.find(params[:id])
    @user.destroy
    flash[:danger] ="User have been deleted"
    redirect_to users_path
  end

  def admin
    @user =User.find(params[:id])
    @user.admin!
    redirect_to users_path , notice: "#{@user} now is admin"
  end

  def manager
    @user =User.find(params[:id])
    @user.manager!
    redirect_to users_path , notice: "#{@user} now is manager user"
  end

  def usual
    @user =User.find(params[:id])
    @user.usual!
    redirect_to users_path , notice: "#{@user} now is usual user"
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:norm)
  end



end

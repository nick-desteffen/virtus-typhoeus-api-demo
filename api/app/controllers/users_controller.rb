class UsersController < ApplicationController

  respond_to :json

  def index
    query_params = params.slice(:first_name, :last_name, :email)
    respond_with(User.includes(:addresses).where(query_params))
  end

  def show
    user = User.find(params[:id])
    respond_with(user, root: false)
  end

  def create
    user = User.create(user_attributes)
    respond_with(user, root: false)
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_attributes)
    respond_with(user, root: false)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

private

  def user_attributes
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

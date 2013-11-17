class UsersController < ApplicationController

  def index
    if params[:search]
      @users = User.where(params[:search])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.persisted?
      redirect_to users_path, notice: "Created user!"
    else
      flash.now.alert = 'Error creating user'
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(params[:id], params[:user])
    if @user.errors.empty?
      redirect_to users_path, notice: "Updated user!"
    else
      flash.now.alert = 'Error updating user'
      render action: :edit
    end
  end

  def destroy
    if User.destroy(params[:id])
      redirect_to users_path, notice: "Destroyed user!"
    else
      redirect_to users_path, alert: "There was an error destroying the user"
    end
  end

end

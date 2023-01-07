# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :admin_authorize_login, only: [:login]
  before_action :admin_authorize_logout, only: [:dashboard]
  layout 'admin_app'
  def index
    redirect_to login_admin_index_path
  end

  def login
    # render plain: "Admin Login Page"
  end

  def submit_login
    if (params[:admin][:email] == 'admin@mybasecamp.com') && (params[:admin][:password] == 'qwazar')
      session[:admin_logged_in] = true
      flash[:success] = 'Welcome Admin, you are logged in successfully!'
      redirect_to dashboard_admin_index_path
    else
      flash[:error] = 'Please Provide Correct Admin Email And Password'
      render 'login'
    end
  end

  def dashboard; end

  def users
    @pagy, @users = pagy(User.all, items: 5)
  end

  def projects
    @user = User.find_by(userid: params[:userid])
    @pagy, @projects = pagy(@user.projects, items: 5)
    render 'user_projects'
  end

  def set_admin
    @user = User.find_by(userid: params[:userid])
    @user.isAdmin = 1
    # render plain: @user.inspect
    if @user.save
      flash[:success] = "User #{@user.fullname} has been given Admin Privilege"
    else
      flash[:error] = "User #{@user.fullname} Could not be set as Admin"
    end
    redirect_to users_admin_index_path
  end

  def unset_admin
    @user = User.find_by(userid: params[:userid])
    @user.isAdmin = 0
    # render plain: @user.inspect
    if @user.save
      flash[:success] = "User #{@user.fullname} admin privilege has been discarded"
    else
      flash[:error] = "User #{@user.fullname} admin privilege was not discarded"
    end
    redirect_to users_admin_index_path
  end

  def logout
    session[:admin_logged_in] = nil
    flash[:error] = 'You are logged out Successfully!'
    redirect_to login_admin_index_path
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end

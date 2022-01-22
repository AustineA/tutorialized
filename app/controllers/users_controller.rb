class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:update, :show, :change_password, :destroy]

  rescue_from ActiveRecord::RecordNotUnique  do |exception|
    render json: { message: "Account already exist, kindly register with another email and username"}, status: :conflict
  end

  def create
    if User.where(username: params[:user][:username], email: params[:user][:email]).exists?
      render json: { message: "Account already exist" }, status: :conflict
      return
    end

    @user = User.new(user_params)
    
    if @user.save
      render json: { message: "Account created! Sign in to continue" }, status: :created
    else
      render json: { message: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end


  def update
    if @user == current_user
        if params[:user][:avatar].present?
          @user.avatar.purge
          @user.avatar.attach(params[:avatar])
        end

        if @user.update!(user_params)
          render json: { message: "Account updated" }, status: :ok
        else
          render json: { message: @user.errors.full_messages.to_sentence }
        end
      else
        render json:   { message: "You're not authorized to carry out this action" }
    end
  end

  def destroy
    if @user == current_user
      @user.destroy
      render json: { message: "Account deleted" }, status: :ok
    else
        render json:   { message: "You're not authorized to carry out this action" }
    end
  end

  def show

  end

  def iforgot
    @user = User.find_by(email: params[:user][:email])
    if @user.present?
      temp_password = SecureRandom.hex(10)
      @user.update!(:password => temp_password )
      # UserMailer.iforgot(@user, temp_password).deliver_later
      render json: { message: "A temporary password has been sent to your email" }
    end
  end


  def change_password
    @user = current_user

    if  params[:user][:old_password].present? && params[:user][:new_password].present? && @user.authenticate(params[:user][:old_password])
      @user.update!(password: params[:user][:new_password] )
        render json: { message: "Password changed" }, status: :ok
    else
      render json: {message: @user.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end


  def destroy_avatar
    if @user == current_user
      @user.avatar.purge
      render json: { message: "Avatar deleted" }, status: :ok
    else
      render json:   { message: "You're not authorized to carry out this action" }, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find_by_username(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :old_password, :new_password, :avatar, :username, :email, :password, :l_name, :f_name )
  end

end

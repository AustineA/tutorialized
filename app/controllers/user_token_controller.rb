class UserTokenController < ApplicationController

  def create
    unless auth_from_password
      render json: {}, status: 404
      return
    end

    user = auth_from_password
    render json: {
        jwt: encode({ sub: user.id }),
        user: {
          firstName: user.f_name,
          lastName: user.l_name,
          author: user.author,
          link: user.link,
        }
      }, status: :created

  end
  
  private

  def auth_from_password
		user = (User.find_by username: params["auth"]["username"]) || ( User.find_by email: params["auth"]["email"] )
    return false unless user
    user.authenticate(params[:auth][:password])
  end


  def auth_params
    params.require(:auth).permit(:username, :password, :email)
  end

end
module Auth
  extend ActiveSupport::Concern
  def current_user
    if decode_user
      begin
        user = User.find(decode_user)

        if user.nil?
          render json: { message: "Please login to continue"}, status: :unauthorized
          return false
        end

        user
      rescue
        return false
      end
    end
  end

  def authenticate_user
    unless current_user
      render json: { message: "Please login to continue"}, status: :unauthorized
    end
  end


  def current_token_user reason
    token = params[:token] if params[:token]
    user = User.find_signed(token, purpose: reason) || current_user

    unless user
      return false
    end

    return user
  end

  
  def authenticate_token_user reason
    unless current_token_user reason
      render json: { message: "Please login to continue"}, status: :unauthorized
    end
  end
  

  private

  def token_from_request_headers
    unless request.headers['Authorization'].nil?
      request.headers['Authorization'].split.last
    end
  end

  def encode payload
    token = JWT.encode payload, Rails.application.credentials.secret_key_base, 'HS256'
  end

  def decode_user
    return false unless token_from_request_headers

    begin
      decoded_token = JWT.decode token_from_request_headers, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' }
      return decoded_token[0]['sub']
    rescue 
      return false
    end
  end

end
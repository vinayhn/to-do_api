class ApplicationController < ActionController::API

    def authenticate

      token = request.headers['HTTP_WWWAUTHENTICATE']
      puts "token in authenticate #{token}"
      return if token.blank?
      decoded_jwt_token = JWT.decode token, nil, false
      @current_user = User.find_by(token: decoded_jwt_token.first["token"].to_s)     
        
    end
end

require 'jwt'
class UsersController < ApplicationController
 

  before_action :check_user, except: [:logout,:send_new_password_email,:create_user]
  before_action :authenticate, except:[:login]
  def create_user
    
    user = User.new(user_params.merge({password_digest: BCrypt::Password.create(params[:password_digest])}))
    puts "password at todo#{params[:password_digest]}"
    if user.save
      render json: user, status: :created, location: @user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login
    token = @user.name + SecureRandom.hex
    @user.update(token: token)
    #puts "user token#{@user}"
    payload = { token: token}
    jwt_token = JWT.encode payload, nil, 'none'
    response.headers["HTTP_WWWAUTHENTICATE"] = jwt_token 
    if token
      render json: {user_name: @user.name, message: "logged in succesfully"}, status: 200 
    else
      render json: {message: "error"}
    end
  end

  def logout
    token_data = @current_user.token
    if token_data.nil?
      return
      else
        @current_user.update(token: nil)
        render json: {user_name: @current_user.name, message: "logged out succesfully"}, status: 200 
        return
    end 
       
  end

  def send_new_password_email
 
    user = User.find_by(email: params[:email])
    new_password = params[:new_password]
    confirm_password = params[:confirm_password]
    if confirm_password.eql? new_password
      user.update(password_digest: BCrypt::Password.create(new_password)) 
      #UserMailer.send_new_password(user).deliver
      render json: {message: "password updated succesfully"}
      return
    end
  
    render json: {message: "passwords dont match"}
        
  end


  private
    def check_user
      #puts request.body.as_json
     # puts "email:   #{params[:email]}" 
      #puts "password:    #{params[:password]} "
      @user = User.find_by(email: params[:email])
     # puts "user_data: #{@user.as_json}"
    #  puts "user_auth:  #{@user.authenticate(params[:password])} "
      render json: @user, status: 401 and return if (@user.blank? || !@user.authenticate(params[:password]))

    end


    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password_digest,:token)
    end
end

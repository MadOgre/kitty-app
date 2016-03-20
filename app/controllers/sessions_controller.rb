class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.find_by_username(login_params[:username])
		if @user && @user.authenticate(login_params[:password])
			session[:user_id] = @user.id
			flash[:success] = "Welcome back, #{@user.fullname == '' ? @user.username : @user.fullname}"
			redirect_to users_path
		else
			flash[:danger] = "There was something wrong, please check your settings and try again"
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Thank you for playing, you have been logged out. Y'all Come back now, ya hear?"
		redirect_to root_path
	end

private
	def login_params
		params.require(:user).permit(:username, :password)
	end

end

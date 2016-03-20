class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
helper_method :logged_in?, :current_user

	def current_user
		@current_user ||= User.find(session[:user_id])
	end

	def require_user
		if !logged_in?
			flash[:danger] = "You must be a logged in user to do that!"
			redirect_to login_path
		end
	end

  def logged_in?
  	!!session[:user_id]
  end

end

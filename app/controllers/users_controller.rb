class UsersController < ApplicationController

	before_action :set_user, except: [:index, :create, :new]

	def index
		@users = User.all
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.email = @user.email.downcase
		if @user.save 
			flash[:success] = "Created new user successfully"
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			render "new"
		end

	end

	def edit
		require_user
	end

	def update
		require_user
		if @user.update(user_params)
			flash[:success] = "User updated successfully"
			redirect_to user_path(@user)
		else
			render "edit"
		end

	end

	def destroy
		require_user
		if logged_in? 
			if current_user.id == @user.id
				@user.destroy
				flash[:success] = "User successfully deleted"
				session[:user_id] = nil
				redirect_to root_path
			else
				flash[:warning] = "Ooops, what did you do?"
				redirect_to users_path
			end
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :fullname, :email, :password, :password_confirmation)
	end

	def set_user
		@user = User.find(params[:id])
	end

end
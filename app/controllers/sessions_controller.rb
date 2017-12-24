class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    def new
    end

    def create
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:notice] = ["Hello #{@user.alias_name}!"]
            redirect_to "/bright_ideas"
        else 
            flash[:errors] = ["Invalid login combination."]
            redirect_to :back
        end
    end

    def destroy
        reset_session
        flash[:notice] = ["Logged out successfully."]
        redirect_to "/main"
    end
end

class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    
    def new 
    end

    def create
        @user = User.new user_params
        if @user.save
            flash[:notice] = ["Registration successful. Please log in."]
            redirect_to "/main"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
        end
    end

    def edit
        @user = User.find(session[:user_id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update user_params
            flash[:notice]=["Profile updated successfully."]
            redirect_to "/bright_ideas"
        else
            flash[:errors] = @user.errors.full_messages     
            redirect_to :back
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            reset_session
            flash[:notice]=["Profile has been deleted."]
            redirect_to "/main"
        else
            flash[:errors]=@user.errors.full_messages
            redirect_to :back
        end
    end  

    def show
        @user = User.find(params[:id])
    end
    
    def index
        @user = User.find(session[:user_id])
        @ideas = Idea.all
    end

    private

    def user_params
        params.require(:user).permit(:name, :alias_name, :email, :password, :password_confirmation)
    end
end

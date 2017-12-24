class LikesController < ApplicationController
    def create
        @idea = Idea.find(params[:id])
        @user = User.find(session[:user_id])
        @like = Like.new(idea:@idea,user:@user)
        if @like.save
            flash[:notice]=["Idea liked."]
            redirect_to :back
        else 
            flash[:errors]=["You already liked this."]
            redirect_to :back
        end
    end

    def destroy
        @idea = Idea.find(params[:id])
        @user = User.find(session[:user_id])
        @like = Like.find(user:@user.id,idea:@idea.id)
        if @like
            @like.destroy
            flash[:notice] = ['Idea unliked.']
            redirect_to :back
        else
            flash[:errors] = ["You haven't liked this idea yet."]
            return redirect_to :back
        end
    end

    def index
    end

end

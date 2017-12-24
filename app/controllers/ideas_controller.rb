class IdeasController < ApplicationController
    def index #all
    end

    def create #post idea from dashboard
        @user = User.find(session[:user_id])
        @idea = Idea.new(idea_params)
        if @idea.valid?
            @idea.user = @user
            @idea.save
            flash[:notice] = ["Idea posted."]
            redirect_to :back
        else
            flash[:errors] = ["Idea can't be blank."]
            redirect_to :back
        end
    end

    def show #one
        @idea = Idea.find(params[:id])
        @user = User.find(@idea.user)
        @likes = Like.where(idea:@idea.id)
    end

    def edit #render update form
        @idea = Idea.find(params[:id])
    end

    def update #post update form
        @idea = Idea.find(params[:id])
        if @idea.update(idea_params)
            flash[:notice] = ["Idea updated successfully."]
            return redirect_to :back
            end
        else
            flash[:errors] = ["There was an error updating this idea."]
            return redirect_to :back
    end

    def destroy #delete
        @idea = Idea.find(params[:id])
        if @idea.user == current_user
            @idea.destroy
            flash[:notice] = ['Idea was deleted.']
            return redirect_to :back
        else
            flash[:errors]=["There was an error deleting this idea."]
            return redirect_to :back
        end
    end

    private
	def idea_params
		params.require(:idea).permit(:content,:user)
    end
end

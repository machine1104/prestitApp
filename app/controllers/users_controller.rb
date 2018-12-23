class UsersController < ApplicationController
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)    # Not the final implementation!
        if @user.save
            redirect_to root_path
            flash[:success] = "Utente creato"
        else
            flash[:danger] = "Errore"
            render 'new'
        end
    end
    
    def index
    end
    
    def user_params
        params.require(:user).permit(:name, :total)
    end
    
end

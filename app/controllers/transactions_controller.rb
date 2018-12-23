class TransactionsController < ApplicationController

    def new
        @transaction = Transaction.new
    end
    
    def index
    end
    
    def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
            redirect_to root_path
        else
            flash.now[:danger] = "Errore"
            render 'new'
        end
    end
    
    
    def transaction_params
        params.require(:transaction).permit(:description, :amount,:user_id, :type)
    end
    
    
    
end

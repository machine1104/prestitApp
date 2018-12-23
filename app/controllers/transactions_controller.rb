class TransactionsController < ApplicationController

    def new
        @transaction = Transaction.new
    end
    
    def index
    end
    
    def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
            amount = @transaction.amount
            #user = User.find(@transaction.user_id)
            #puts user.total
            #totale = user.total
            #user.update_params(total: totale+amount)
            #puts user.total
            #user.save
            redirect_to root_path
            flash[:success] = "Transazione creata"
        else
            flash[:danger] = "Errore"
            render 'new'
        end
    end
    
    
    def transaction_params
        params.require(:transaction).permit(:description, :amount,:user_id, :type)
    end
    
    
    
end

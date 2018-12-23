class TransactionsController < ApplicationController

    def new
        @transaction = Transaction.new
    end
    
    def index
        @transactions = Transaction.paginate(page: params[:page], per_page: 15).reorder("created_at DESC")
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
    
    def destroy
        Transaction.find(params[:id]).destroy
        flash[:success] = 'Transazione eliminata'
        redirect_to root_path
    end
    
    
    def transaction_params
        params.require(:transaction).permit(:description, :amount,:user_id, :type)
    end
    
    
    
end

class Transaction < ApplicationRecord
    belongs_to :user
    after_save :update_user
    
    validates :user_id, presence: true
    validates :description, presence: true
    validates :amount, presence: true
    
    protected
    
    def update_user
        user = User.find(self.user_id)
        user.total = user.total + self.amount
        user.save
    end
    
end

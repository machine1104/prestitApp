class Transaction < ApplicationRecord
    belongs_to :user
    after_save :update_user
    after_destroy :update_user_destroy
    
    validates :user_id, presence: true
    validates :description, presence: true
    validates :amount, presence: true
    
    protected
    
    def update_user
        user = User.find(self.user_id)
        user.total = user.total + self.amount
        user.save
    end
    
    def update_user_destroy
        user = User.find(self.user_id)
        user.total = user.total - self.amount
        user.save
    end
    
end

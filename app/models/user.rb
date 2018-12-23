class User < ApplicationRecord
    has_many :transactions
    after_initialize :init
    
    validates :name, presence: true, uniqueness: true

    def init
        self.total  ||= 0.0           #will set the default value only if it's nil
    end
    
    
end

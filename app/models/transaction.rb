require 'http'


class Transaction < ApplicationRecord
    
    belongs_to :user
    
    after_save :update_save
    after_destroy :update_destroy
    
    validates :user_id, presence: true
    validates :description, presence: true
    validates :amount, presence: true, numericality: { only_float: true }
    
    
    protected
    
    def update_save
        user = User.find(self.user_id)
        user.total = '%.2f' % (user.total + self.amount)
        user.save
        
        @LINK = "https://api.telegram.org/bot"+ENV["TELEGRAM_BOT_API"]+"/sendMessage?chat_id="+ENV["CHANNEL"]+"&text="
        
        m = "#Totale "+ User.sum(:total).to_s
        m += "\n"
        User.all.each do |u|
          m += "\n#Prestiti#{u.name} #{u.total.to_s}€"
        end
        
        m += "\n\n#{self.amount.to_s}€ #{self.description} - #{User.find(self.user_id).name}"
        url = URI.parse(URI.encode(@LINK+m))
        res = HTTP.get(url).to_s
        
    end
    
    def update_destroy
        user = User.find(self.user_id)
        user.total = '%.2f' % (user.total - self.amount)
        user.save
        
        @LINK = "https://api.telegram.org/bot"+ENV["TELEGRAM_BOT_API"]+"/sendMessage?chat_id="+ENV["CHANNEL"]+"&text="
        
        m = "#Totale "+ User.sum(:total).to_s
        m += "\n"
        User.all.each do |u|
          m += "\n#Prestiti#{u.name} #{u.total.to_s}€"
        end
        
        m += "\n\nTransazione eliminata: #{self.amount.to_s}€ #{self.description} - #{User.find(self.user_id).name}"
        url = URI.parse(URI.encode(@LINK+m))
        res = HTTP.get(url).to_s
        
    end
    
end

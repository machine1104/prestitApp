require 'http'


class Transaction < ApplicationRecord
    
    belongs_to :user
    
    after_save :update_save
    after_destroy :update_destroy
    
    validates :user_id, presence: true
    validates :description, presence: true
    validates :amount, presence: true
    
    protected
    
    def update_save
        user = User.find(self.user_id)
        user.total = user.total + self.amount
        user.save
        
        @API = "629726812:AAHC5UyTBd6sd2rLE5qYF_FsAOSUS_Fwc7s"
        @CHANNEL = "-1001494343697"
        @LINK = "https://api.telegram.org/bot"+@API+"/sendMessage?chat_id="+@CHANNEL+"&text="
        
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
        user.total = user.total - self.amount
        user.save
        
        @API = "629726812:AAHC5UyTBd6sd2rLE5qYF_FsAOSUS_Fwc7s"
        @CHANNEL = "-1001494343697"
        @LINK = "https://api.telegram.org/bot"+@API+"/sendMessage?chat_id="+@CHANNEL+"&text="
        
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

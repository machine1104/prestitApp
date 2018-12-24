class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def totale_prestiti
        User.sum(:total).to_d
  end
  
  helper_method :totale_prestiti
  
end

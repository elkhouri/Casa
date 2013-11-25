class PagesController < ApplicationController
  before_action :signed_in_user, only:[:feedback, :contact]
  
  def index
    if !signed_in?
      redirect_to signin_url
    end
  end
  
  def feedback
  end
  
  def contact
  end
end

class PagesController < ApplicationController
  before_action :signed_in_user
  
  def index
    redirect_to current_user
  end
  
  def feedback
  end
  
  def contact
  end
end

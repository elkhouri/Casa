class PagesController < ApplicationController
  before_action :signed_in_user
  
  def index
    if current_user.admin?
      redirect_to admin_path
    else
      redirect_to current_user
    end
  end
  
  def feedback
  end
  
  def stats
    @title = "Statistics"
  end
  
  def contact
    @user = current_user
  end

end
